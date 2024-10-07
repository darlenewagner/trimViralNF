#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

process blastN {
   
   publishDir "$PWD/blastn_output/", mode: 'copy'

   input:
     path(reference) 
     path(query)
     
   output:
     path "${query.simpleName}.blastn.txt"
   
   """
     echo 'Hello World Here. Comes Your Girl Here!' > "${query.simpleName}.blastn.txt"
   """
  
}




workflow {

  params.reference = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_db/AY184220"]
  
  params.query = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/polio_contigs/polio_sample_10.fasta"]
  
  blastN(params.reference, params.query) | view
}
