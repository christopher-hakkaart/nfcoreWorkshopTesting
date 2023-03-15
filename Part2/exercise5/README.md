# Exercise 5: Specifying external arguments to a process

## Objectives 
- Discuss the importance of reading the tool documentation for key tools in the workflow to decide on customised parameters
- Identify which tool parameters are included by nf-core, either hard-coded or customisable as a workflow argument either by command line or parameters file
- Learn how to specify additional external arguments to a process ie those that are available to the tool but not covered by nf-core arguments

---------------------
## Testing reflection

---------------------
## Content draft 

nf-core provides a number of flexible parameters for each process in the workflow. These are specified with the double dash syntax on the command line, or saved in a parameters file as we have covered in the previous exercises.

However, nf-core has not included every possible parameter that is available to every tool within the workflow; they have included only those most commonly changed from the default as chosen by the software developers. 

For example, look at the parameter options for the tool Trim Galore, under [Read trimming options](https://nf-co.re/rnaseq/3.10.1/parameters)

You will see 8 parameters, 6 of which are Trim Galore-specific parameters and the last 2 which are nf-core parameters. 

Now look at the full list of [Trim Galore parameters](https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md#general-options). It would be very unwieldy for nf-core to cover all of the available options for this tool and every other in the workflow on their main workflow page!

You have the flexibility to use ANY tool parameter, whether a parameter is specified by the nf-core workflow parameters page or not, by providing these as **extra arguments**.
 
View the Trim Galore process `main.nf`: 
```bash
cat -n ../rnaseq/modules/nf-core/trimgalore/main.nf
```

Look at the top of the `script:` block (lines 24-25):
```bash
script:
def args = task.ext.args ?: ''
```

We can use the `ext.args` variable to parse any tool parameters to the tool command run by the process. Neat huh! 

Now look at the actual `trim_galore` run command (starting at line 42 or 58). 

We can see that nf-core has hardcoded the parameters `cores` and `gzip`, and also fed in the `paired` argument if the input is detected as paired-end reads. 

As a researcher, its up to you to decipher what customisations are required to make your analysis suitable for your data and research questions. 

In order to understand what parameters you may want to specify as extra arguments, its first important to: 
a) Read the tool documentation to understand all the available parameters for that tool
	- Tool doc
b) View the list of nf-core parameters for that tool
	- nf-core workflow params page
c) View which paramteres are hard-coded within the nextflow process 
	- process main.nf
	
Then, if parameters you want to use are not covered by the nf-core parameters or hard-coded in the run command, you can add them using the `ext.args` variable. 

For the sake of the exercise, let's assume we want to increase the minimum quality Phred score from the default of 20 to a much more stringent value of 30. 

Following the Trim Galore user guide, we would do this with the syntax `--quality 30`. 

To parse that to the Trim Galore process, we need to specify this in a custom config, just like we have done for `max_cpus`, `max_memory` and `outdir` in the previous exercises. 

The difference this time is that we want to restrict the usage of the parameter to the only place it makes sense - to the `TRIMGALORE` process. 


Open `nextflow.config` for editing, then add the following content:

```bash
process {
    withName: 'FASTQC_UMITOOLS_TRIMGALORE:TRIMGALORE' {
        ext.args    =   '--quality 30'
    }
}
``` 

Re-run the previous command specifying `--outdir exercise5`, and observe that this time, since the input data has been changed (more aggressively trimmed), the analysis steps are re-run rather than restored from cache. 

---------------------
## Troubleshooting

The ext.args syntax to trimgalore is not working for me. 

I initially tried this in my local `nextflow.config`:

```
process {
    withName: 'FASTQ_FASTQC_UMITOOLS_TRIMGALORE:TRIMGALORE' {    
        ext.args    =   '--quality 40'
    }
}
```

However the changed parameter is NOT listed in the 'changed params' section of STDOUT, and the trimglaore reports for the reads show the default value of 20 is still being used. 

Chris said this worked for him:

```
process {
    withName : ".*:TRIMGALORE" {
        ext.args   = { "WRITE STUFF HERE " }
    }

```

I tried this wildcard notation to the process label, and it also did not apply the new quality value. 

Hang on now it did - need to re-test to confirm my sanity, was I editing the right config. BUT that aside, there is a new issue apparent:

The param is NOT listed in STDOUT, but the vlaue of 40 IS now in the trimgalore reads report. YET the STAR data is pulled from cache! The number of reads trimmed is huge (98% for 40 vs ~1% for 20) so WHY IS THE BAM BEING PULLED FROM CACHE. Need to explore this - have just issued a run WITHOUT the resume flag, so that I can directly compare the BAMs

Output dirs - 

Results - the initial, qual not working
ResultsTEST - using Chris notation, with RESUME flag
Results40QualNoResume - using Chris notation, with NO resume flag

The above run only took 3.5 minutes to run, because the trimmed reads files were tiny on account of the aggressive trimming. Next, compare the STAR BAMs to demonstrate that the output in ResultsTEST should NOT have been pulled from cache... (not done yet, need to come back to this)


The example in the documentation shows to use single quotes around what is supplied to ext.args, but Chris has shown curly brackets. I tried with curly brackets, kinda expecting it to error - it did not error, and once again it did not apply the custom quality value. 

The other parameters specified in my local `nextflow.config` ARE being correctly applied. Here is the full config:

```
#!/usr/bin/env nextflow

nextflow.enable.dsl=2

singularity {
    enabled = true
}

trace.overwrite = true
dag.overwrite = true
report.overwrite = true
timeline.overwrite = true

params.max_cpus = 2
params.max_memory = '6 GB'
params.outdir = "Results"

// Produce a workflow diagram and HTML reports  
dag {
        enabled = true
        file = "${params.outdir}/dag.svg"
}
report {
        enabled = true
        file = "${params.outdir}/report.html"
}
timeline {
        enabled = true
        file = "${params.outdir}/timeline.html"
}
trace {
        enabled = true
        file = "${params.outdir}/trace.txt"
}

// Custom Phred quality threshold for trimming    
// withName: 'FASTQ_FASTQC_UMITOOLS_TRIMGALORE:TRIMGALORE' 
process {
    withName: ".*:TRIMGALORE" {    
        ext.args    =   '--quality 40'
    }
}

```




---------------------
## Links/resources 








