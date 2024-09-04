#! /apps/x86_64/nextflow/21.04.3 nextflow

//params.querydir = "$PWD/test_genomes/*.fasta"

// Change the filepath in Channel.fromPath() to read fasta files with a single sequence each
// params.querydir = "$PWD/Graces_Polio_miseq_with_QC/folders_to_polio.txt"
// myString = params.id



datasets = Channel
           .fromPath('/scicomp/home-pure/ydn3/Graces_Polio_miseq_with_QC/301582????_S??_polio_miseq_afterbbduk_assembly/contigs.verified/NODE_*.fasta', glob: true)
//	   .splitText() { it.strip() }
//           .view()



if (params.help) {
    helpMessage()
    exit 0
}

process runBlast {

  publishDir "/scicomp/home-pure/ydn3/nextflowTrimViral/blastnIO/", mode: 'copy'
  
  input:
  file fasta_file from datasets
  
  output:
  file "${fasta_file.getBaseName()}.myBlast.tab" into intermediate
  file "${fasta_file.getBaseName()}.fasta" into nextIntermediate

  script:
  """
  module load ncbi-blast/2.10.0
  blastn  -num_threads $params.threads -db $params.dbDir/$params.dbName -query $fasta_file -outfmt $params.outfmt $params.options -out ${fasta_file.getBaseName()}.myBlast.tab
  module unload ncbi-blast/2.10.0
  """
}

process showOutput {

        publishDir "/scicomp/home-pure/ydn3/nextflowTrimViral/tentativeOutput/", mode: 'copy'

        input:
	
        file file1 from intermediate
	file file2 from nextIntermediate

        output:
       // stdout into result
	file "${file1.baseName}.trimmed.fasta" into trimming
	

        script:
        """
        module load Python/3.9.1
        /scicomp/home-pure/ydn3/nextflow_tutorial/fetchMedianTrim.py $file1 $file2 >> "${file1.baseName}.trimmed.fasta"
         
        module unload Python/3.9.1
        """
}


// datasets.view { it.trim() }



def helpMessage() {
  log.info """
        Usage:
        The typical command for running the pipeline with an unmodified nextflow.config:
        nextflow run blastnCOVIDextract.nf

        The command for running the pipeline with custom query, blastDB directory, and blastDB name.
        nextflow run blastnCOVIDextract.nf --query QUERY.fasta --dbDir "blastDatabaseDirectory" --dbName "blastPrefixName"

       Optional arguments:
        --query                        Query fasta file of sequences you wish to BLAST
        --dbDir                        BLAST database directory (full path required)
        --dbName                       Prefix name of the BLAST database
        --outdir                       Output directory to place final BLAST output
        --outfmt                       Output format ['6']
        --options                      Additional options for BLAST command [-evalue 1e-3]
        --threads                      Number of CPUs to use during blast job [16]
        --help                         This usage statement.
        """
}
