### Requires nextflow version 23.10.0 or higher

#### Simple setup
`module load perl/5.30.1`
##### Perl version 5.30 or higher recommended
`perl setup.pl`


#### Example with all prerequisites available on server:
` nextflow run trimViralContigs.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annot "$PWD/annotated/" --intermediate "$PWD/intermediate/"`

#### Example with blastn and perl implemented through singularity:
##### Pull and Build -
`singularity pull https://depot.galaxyproject.org/singularity/blast:2.14.1--pl5321h6f7f691_0`
`singularity build my_blast_2.14.1.sif blast\:2.14.1--pl5321h6f7f691_0`
`singularity pull https://depot.galaxyproject.org/singularity/perl:5.32`
`singularity build my_perl.sif perl\:5.32`


##### Run .singularity.nf version of pipeline
`nextflow run trimViralContigs.singularity.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annot "$PWD/annotated/" --intermediate "$PWD/intermediate/"`