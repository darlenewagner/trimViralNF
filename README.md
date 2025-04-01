## trimViralNF: A Trimmer for de novo viral genome assemblies
- Corrects overassembly beyond length of nearest reference genome
- Requires nextflow version 23.10.0 or higher

---

#### Vignette 1: BlastN and perl implemented through singularity, with local Nextflow:

`tar xvf test_genomes.tar`

##### Install Nextflow via HPC module or Miniconda:

`module load nextflow/24.04.2`

##### Pull and Build through bash, then call containerized makeblastdb:
`./singularityLocalSetup.sh`

`singularity exec my_blast.sif makeblastdb -dbtype nucl -in blastn_db/poliovirus/MZ245455.1.fasta -out blastn_db/poliovirus/MZ245455`

##### Run .singularity.nf version of pipeline
`nextflow run trimViralContigs.localSingularity.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annote "$PWD/annotated/" --intermediate "$PWD/intermediate/"`

---


#### Vignette 2: Nextflow, BlastN, and perl implemented through HPC modules
##### Prerequisites setup from path to local sources
`./shellSetupWrapper.sh`

`source ~/.bash.d/nextflow.bash`

##### Note: paths to executables in *moduleWrapper.sh* may need editing

#### Format reference genome of choice
`makeblastdb -dbtype nucl -in blastn_db/mastadenovirus_A/MN901835.1.fasta -out blastn_db/mastadenovirus_A/MN901835`

##### Note: repeat for poliovirus/ and norovirus/


#### Populate folder for test input, 'anonymousContigs/'
`perl perl/fillAnonymous.pl test_genomes/polio_sample_10.fasta`

#### An additional script is non-ASCII '\r\n' endline remains
`perl perl/removeDemonCharacter.pl < anonymousContigs/contig01.fasta`


#### Example run after shellSetupWrapper.sh installation:
##### Mastadenovirus A from test_genomes/
`nextflow run trimViralContigs.nf`

##### polio_sample_1(0|1) input from test_genomes/Wagner_et_al_poliovirus/
` nextflow run trimViralContigs.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annote "$PWD/annotated/" --intermediate "$PWD/intermediate/"`

