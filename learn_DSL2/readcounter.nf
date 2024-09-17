#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

// params.reads = "$PWD/../../Competency_Item_1_B_IV_2/*_R{1,2}_raw.fastq"
params.reference = "$baseDir/../../Competency_Item_1_B_IV_2/norovirus_reference/OL913976"
params.outdir = "$baseDir/../../Competency_Item_1_B_IV_2/norovirus_reference/output/"

process READCOUNT {

//    tag { see }
    publishDir '$baseDir/../../Competency_Item_1_B_IV_2/norovirus_reference/output/', mode: 'copy', overwrite: true

    input:
    tuple val(sample_name), path(reads)

    output:
    tuple val(sample_name), path(*.txt)

    script:
    """
    ls $sample_name
    """
}

workflow {
    channel
        .fromFilePairs("$baseDir/../../Competency_Item_1_B_IV_2/*_R{1,2}_raw.fastq", checkIfExists: true)
	.set{read_pairs_ch}
	
    READCOUNT(read_pairs_ch)

}
