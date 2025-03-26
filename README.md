### Requires nextflow version 23.10.0 or higher

#### Exact path to prerequisites setup
`./shellSetupWrapper.sh`

`source ~/.bash.d/nextflow.bash`

##### Note: paths to executables in 'moduleWrapper.sh' may need editing

#### Format reference genome of choice
`makeblastdb -dbtype nucl -in blastn_db/mastadenovirus_A/MN901835.1.fasta -out blastn_db/mastadenovirus_A/MN901835`

##### Note: repeat for poliovirus/ and norovirus/


#### Populate folder for test input, 'anonymousContigs/'
`perl perl/fillAnonymous.pl test_genomes/polio_sample_10.fasta`

#### An additional script is non-ASCII '\r\n' endline remains
`perl perl/removeDemonCharacter.pl < anonymousContigs/contig01.fasta`


#### Example with all prerequisites available on server:
` nextflow run trimViralContigs.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annote "$PWD/annotated/" --intermediate "$PWD/intermediate/"`

#### Example with blastn and perl implemented through singularity:
##### Pull and Build using bash script:
`./singularitySetupWrapper.sh`

##### Run .singularity.nf version of pipeline
`nextflow run trimViralContigs.singularity.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annote "$PWD/annotated/" --intermediate "$PWD/intermediate/"`