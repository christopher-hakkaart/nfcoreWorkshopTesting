# Exercise 4: Customise execution - further practice

## Objectives 
- Create a custom config for multiqc
- Add the custom config details to the parameters YAML file 
- Run with the -resume flag
- This exercise provides practice in:
  - Reading the documentation and selecting parameters that are suited to the specific data analysis at hand
  - Creating another configuration file in YAML format
  - Editing a parameters YAML file
  - Observing the order of priorities for configuration - like nextflow, the multiqc parameters are read from the main multiqc tool, with our locally psecified parameters overriding these
  - Observing the behaviour of nextflow cache and the '-resume' flag; only the multiqc module was changed and so only this part was re-run, while all other tasks were recovered from cache
---------------------
## Testing reflection

---------------------
## Content draft 

Create a file in working directory called `multiqc_config.yaml`.  

Add the following to this file:  

```
fastqc_config:  

  fastqc_theoretical_gc: "mm10_txome" 
```

To the `exercise2_params.yaml` file, add:  

```
multiqc_config : multiqc_config.yaml 
```

Make sure both YAML files are saved, then run as usual, ensuring the `resume` flag is included: 

```
nextflow run ../rnaseq/main.nf -profile singularity -params-file exercise2_params.yaml -resume 
```

While it is running, observe that all of the other anaylsis steps are restored from cache except for multiqc. 

The changes we made above added the mouse transcriptome GC profile as a track to the fastQC per-sequence GC content plot. To view the changes, copy the output file `multiqc_report.html` to your local computer (eg with `scp`), as well as the same file from the run from Exercise 3 (actually no, because this will override that file, unless we have users change the outdir via params file or command line flag) . Open both files in your internet browser, and via the left hand pane, navigate to `FastQC --> Per Sequence GC Content`. Compare the two plots to observe the custom track has been successfully added.  

*** add this as hints or extra challenge format - 
- location of the multiqc_report.html file is /home/ubuntu/nfcoreWorkshopTesting/exercise2/multiqc/star_salmon - can make an extra challenge to see if user can work out where to look for it given the stdout from the run (ie work/5d/e293 blah blah) 
- - example scp command, eg to to mac term or gitbash, cd to eg Downloads, run `scp ubuntu@<IP>:/<path> .` then open via file explorer to whatever browser 

---------------------
## Troubleshooting

---------------------
## Links/resources 
