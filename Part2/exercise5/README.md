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

the original version of this exercise specified the process FASTQC_UMITOOLS_TRIMGALORE:TRIMGALORE - according to https://github.com/nf-core/rnaseq/blob/master/workflows/rnaseq.nf the process is now called FASTQ_FASTQC_UMITOOLS_TRIMGALORE

When I attempted to run withName on that process, i received "WARN: There's no process matching config selector: FASTQ_FASTQC_UMITOOLS_TRIMGALORE"

---------------------
## Links/resources 








