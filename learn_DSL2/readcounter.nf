#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

process READCOUNT{

    publishDir "$PWD/see/", mode: 'copy'

    input:
    tuple val(sample_name), path(reads)

    output:
    tuple val(sample_name), path("list.txt")

    script:
    """
    echo "${sample_name}"_R1.fastq > "list.txt"
    echo "${sample_name}"_R2.fastq >> "list.txt"
    awk '{s++}END{print s/4}' "${sample_name}"_R1.fastq >> "list.txt"
    awk '{s++}END{print s/4}' "${sample_name}"_R2.fastq >> "list.txt"
    """
}

workflow {

    read_pairs_ch = Channel.fromFilePairs("$PWD/fastq/*_R{1,2}.fastq", checkIfExists: true)
    
    read_pairs_ch.view()
	
    READCOUNT(read_pairs_ch)

}
