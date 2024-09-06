#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

params.reads = "/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/../../Competency_Item_1_B_IV_2/*_R{1,2}_raw.fastq"
params.reference = "/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/../../Competency_Item_1_B_IV_2/norovirus_reference/OL913976"
params.outdir = "/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/../../Competency_Item_1_B_IV_2/norovirus_reference/output/"

process READCOUNT {

//    tag { see }
    publishDir params.outdir, mode:"copy"

    input:
    tuple val(sample_name), path(reads)

    output:
    path "${sample_name}.txt"

    script:
    """
    echo ${sample_name} > ${sample_name}.txt
    awk 'END {print NR/4}' ${reads[0]} >> ${sample_name}.txt
    awk 'END {print NR/4}' ${reads[1]} >> ${sample_name}.txt
    """
}

workflow {
    Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .set { read_pairs_ch }

    READCOUNT(read_pairs_ch)

}
