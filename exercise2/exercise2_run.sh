nextflow run ../rnaseq/main.nf \
    -profile singularity \
    -params-file exercise2_params.yml \
    -with-report execution_report_exercise2.html \
    -with-trace execution_trace_exercise2.txt \
    -with-timeline timeline_exercise2.html \
    -with-dag dag_exercise2.png 
