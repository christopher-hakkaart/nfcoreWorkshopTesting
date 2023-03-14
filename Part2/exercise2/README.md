# Exercise 2: Customise run via parameter schema

## Objectives 
* Write a parameter file
* Understand YAML file format
* Rerun workflow with -params-file
* Understand the use of -params-file for reproducibility and transparency 

---------------------
## Testing reflection
* FYI we did not run default command, cannot do so on instances. Both standard cli run exercises with flags can be merged into one  
* FYI good opportunity to reiterate importance of reproducibility in context of collaboration, sharing, publications
* FYI focus in this exercise is on customising processes, not their execution 
* TODO request Seqera cover configuration heirarchy in session 1 to be reiterated here 
* TODO add email for summary email at end of the run 
  - This does not work, see email_on_complete_error which captures the errors from nextflow.log when attempting to use --email parameter. This was with the latest nextflow and nf-core rnaseq versions
* TODO 
* DONE 
* Q 

---------------------
## Content draft 

Nextflow params variables can be saved in to a JSON or YAML file called nf-params.json and used by Nextflow with the `-params-file` flag. This makes it easier to reuse these in the future.

The command takes one argument - either the name of an nf-core pipeline which will be pulled automatically, or the path to a directory containing a Nextflow pipeline (can be any pipeline, doesn't have to be nf-core).

### Create parameter file
We will create a YAML format file with our inputs. This file can then be saved with the workflow, shared with collaborators etc. A useful reference for the analysis as well as making it easier to rerun/reproduce. 

We would also like to make some changes to the previous run: 
 - [Apply more stringet QC on the input reads](https://nf-co.re/rnaseq/3.10.1/parameters#three_prime_clip_r1) 
 - [Save the trimmed reads to the output directory](https://nf-co.re/rnaseq/3.10.1/parameters#save_trimmed) 

Open a file `exercise2_params.yaml` and add the following:

```
input: "/home/ubuntu/nfcoreWorkshopTesting/materials/samplesheet.csv" 
outdir: "/home/ubuntu/nfcoreWorkshopTesting/exercise2"
gtf: "/home/ubuntu/nfcoreWorkshopTesting/materials/mm10_reference/mm10_chr18.gtf"
fasta: "/home/ubuntu/nfcoreWorkshopTesting/materials/mm10_reference/mm10_chr18.fa"
star_index: "/home/ubuntu/nfcoreWorkshopTesting/materials/mm10_reference/STAR" 
save_trimmed  : true
three_prime_clip_r1 : 5
```
Any of the [workflow parameters](https://nf-co.re/rnaseq/3.10.1/parameters) can be added to the parameters file in this way. 

Reminder: nextflow can use cached output! If we apply the `-resume` flag to the run, nextflow will only compute what has not been changed. We should expect the initial fastqc to be restored from cache and all the other steps to be re-computed, as the input data has been changed (by additioal trimming). 

Once your params file has been saved, run the following, observing how the command is now shorter thanks to offloading some parameters to the params file. Note the use of a single `-` for 'resume' and 'params-file' as these are nextflow options not nf-core parmeters, which would use two dashes.
```
nextflow run ../rnaseq/main.nf \
  --max_memory '6.GB' \
  --max_cpus 2 \
  -profile singularity \
  -with-report execution_report_exercise2.html \
  -with-trace execution_trace_exercise2.txt \
  -with-timeline timeline_exercise2.html \
  -with-dag dag_exercise2.png \
  -resume \
  -params-file exercise2_params.yaml 
```

---------------------
## Troubleshooting

Run time was 1min4s, and all 200 tasks pulled from cache. This is not expected - STAR should have been re-run on the updated fastq input. The trimgalore outdir DOES contain the trimmed reads as requested. Why was the mapping pulled from cache when the input reads have changed?

```
ubuntu@small-testing:~/nfcoreWorkshopTesting$ zcat exercise2/results/trimgalore/SRR3473984_trimmed.fq.gz > trimmed
ubuntu@small-testing:~/nfcoreWorkshopTesting$ zcat materials/fastqs/SRR3473984_selected.fastq.gz > notTrimmed
ubuntu@small-testing:~/nfcoreWorkshopTesting$ sdiff -s trimmed notTrimmed | wc -l
68758
```


---------------------
## Links/resources 

* [Nextflow configuration docs](https://www.nextflow.io/docs/latest/config.html?highlight=params#configuration)
* [Nextflow tips: params file](https://www.nextflow.io/blog/2020/cli-docs-release.html)
* [YAML tutorial](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)
