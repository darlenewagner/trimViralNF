#!/usr/bin/perl
use strict;

## perl -nle 'BEGIN{@name=(); $i=0}; if($_=~/^>/m){$cc = index($_, "_"); $name[$i]=substr($_, 1, $cc - 1); $i++}; END{for($j=0; $j<scalar @name; $j++){print $name[$j],"\n"}}' test_genomes/polio_sample_11.fasta

my $file = $ARGV[0];

open(FASTA, '<', $file) || die "Can't find fasta file, $file $!";

my @name = ();
my $i = 0;

while(<FASTA>)
{
  if($_ =~ /^>/)
   {
      my $cc = index($_, '_');
      $name[$i] = substr($_, 1, $cc - 1);
      my $file2 = $name[$i].".fasta";
      $i++;
      open DAT, '>>', "anonymousContigs/$file2" or die "Can't open anonymousContigs/$file2\n";
      printf DAT $_;
     
   }
  elsif($_ =~ /^(A|C|G|T|N)/)
   {
       printf DAT $_;
   }
}

close FASTA;
