# Exercise 1: Running your first nextflow script

## Checking Nextflow is installed on your system

We can check what version of Nextflow is installed on your system using the `nextflow --version` command.

``` bash
nextflow --version
```

``` bash
printf 'Hello world!' | split -b 6 - chunk_`
```

``` bash
cat chunk_aa | tr '[a-z]' '[A-Z]'`
```

``` bash
#!/usr/bin/env nextflow

params.greeting = 'Hello world!' 

process SPLITLETTERS { 
    input: 
    val x 

    output: 
    path 'chunk_*' 

    script:
    """
    printf '$x' | split -b 6 - chunk_
    """
} 

process CONVERTTOUPPER { 
    input: 
    path y 

    output: 
    stdout 

    
    """
    cat $y | tr '[a-z]' '[A-Z]'
    """
} 

workflow { 
    greeting_ch = Channel.of(params.greeting)

    letters_ch = SPLITLETTERS(greeting_ch) 
    results_ch = CONVERTTOUPPER(letters_ch.flatten()) 
    results_ch.view{ it } 
} 
```