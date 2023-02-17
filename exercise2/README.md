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

---------------------
## Troubleshooting


---------------------
## Links/resources 

* [Nextflow configuration docs](https://www.nextflow.io/docs/latest/config.html?highlight=params#configuration)
* [Nextflow tips: params file](https://www.nextflow.io/blog/2020/cli-docs-release.html)
* [YAML tutorial](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)
