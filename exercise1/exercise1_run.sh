cvmfs_path=/cvmfs/data.biocommons.aarnet.edu.au/Final_resources_250722/Mouse_chr18_reference
materials=/home/ubuntu/nfcoreWorkshopTesting/materials/mm10_reference

nextflow run ../rnaseq/main.nf \
    --input samplesheet.csv \
    --outdir /home/ubuntu/nfcoreWorkshopTesting/exercise1/results \
    --max_memory '6.GB' --max_cpus 2 \
    --gtf $materials/mm10_chr18.gtf \
    --fasta $materials/mm10_chr18.fa \
    --star_index $materials \
    -profile singularity \
    -with-report execution_report_exercise1.html \
    -with-trace execution_trace_exercise1.txt \
    -with-timeline timeline_exercise1.html \
    -with-dag dag_exercise1.png 
