#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

process see {

  publishDir 'see/', mode: 'copy', overwrite: false, pattern: "*"

  

}