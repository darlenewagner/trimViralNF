#!/usr/bin/bash

singularity pull https://depot.galaxyproject.org/singularity/perl:5.32

singularity build my_perl.sif perl\:5.32

singularity pull https://depot.galaxyproject.org/singularity/nextflow:24.04.2--hdfd78af_0

singularity build my_nextflow.sif nextflow\:24.04.2--hdfd78af_0

singularity pull https://depot.galaxyproject.org/singularity/blast:2.14.1--pl5321h6f7f691_0

singularity build my_blast.sif blast\:2.14.1--pl5321h6f7f691_0
