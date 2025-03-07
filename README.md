### Requires nextflow version 23.10.0 or higher

#### Exact path to prerequisites setup
`./moduleWrapper.sh`

`source ~/.bash.d/nextflow.bash`

#### Populate folder for test input, 'anonymousContigs/'
`perl perl/fillAnonymous.pl test_genomes/polio_sample_10.fasta`


##### Note that paths to executables in 'moduleWrapper.sh' may need editing


#### Example with all prerequisites available on server:
` nextflow run trimViralContigs.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annote "$PWD/annotated/" --intermediate "$PWD/intermediate/"`

#### Example with blastn and perl implemented through singularity:
##### Pull and Build using bash script:
`./singularitySetupWrapper.sh`

##### Run .singularity.nf version of pipeline
`nextflow run trimViralContigs.singularity.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annote "$PWD/annotated/" --intermediate "$PWD/intermediate/"`