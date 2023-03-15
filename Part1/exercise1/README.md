# Exercise 1: Running your first nextflow script

Check install

``` bash
nextflow --version
```

Show what commands do

``` bash
printf 'Hello world!' | split -b 6 - chunk_`
```

``` bash
cat chunk_aa | tr '[a-z]' '[A-Z]'`
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

How to run a pipeline

```
nextflow run hello.nf
```

Work directory - isolated processes

```
tree work
```

Configs

``` bash
params.greeting = "hola mundo"
```

```
nextflow run hello.nf
```

```
nextflow run hello.nf --greeting "hallo welt"
```

Caching

``` bash
nextflow run hello.nf
```

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