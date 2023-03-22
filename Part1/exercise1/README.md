# Exercise 1: Running your first Nextflow script

## Check install

``` bash
nextflow --version
```

## Show what commands do

``` bash
mkdir sandbox
cd sandbox
```

``` bash
printf 'Hello world!' | split -b 6 - chunk_
```

Files are created
Change chunk size to 4
Run again
See more chunks

``` bash
cat chunk_aa | tr '[a-z]' '[A-Z]'
```

Show chunk prints in capital letters

``` bash 
cd ..
```

Introduce pipeline

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

    script:
    """
    cat $y | tr '[a-z]' '[A-Z]'
    """
} 

workflow { 
    greeting_ch = Channel.of(params.greeting)
    letters_ch  = SPLITLETTERS(greeting_ch) 
    results_ch  = CONVERTTOUPPER(letters_ch.flatten()) 
    results_ch.view{ it } 
} 
```

## How to run a pipeline

```
nextflow run hello.nf
```

Work directory - isolated processes

```
tree work
```

## Configs

Show docs

Write a new file `nextflow.config`

``` bash
params.greeting = "hola mundo"
```

Run

```
nextflow run hello.nf
```

Write a new file `myconfig.config`

``` bash
params.greeting = "Bonjour le monde"
```

```
nextflow run hello.nf -c myconfig.config
```

Use command line

```
nextflow run hello.nf --greeting "hallo welt"
```

Caching

``` bash
nextflow run hello.nf
```

Edit `hello.nf`

``` bash
process CONVERTTOUPPER { 
    input: 
    path y 

    output: 
    stdout 

    script:
    """
    rev $y
    """
} 
```

``` bash
nextflow run hello.nf
```

Scopes

``` bash
params.greeting = "hola mundo"
```

``` bash
params {
    greeting = "hola mundo"
}
```