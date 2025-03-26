#!/usr/bin/perl
use strict;

## perl -nle 'BEGIN{@name=(); $i=0}; if($_=~/^>/m){$cc = index($_, "_"); $name[$i]=substr($_, 1, $cc - 1); $i++}; END{for($j=0; $j<scalar @name; $j++){print $name[$j],"\n"}}' test_genomes/polio_sample_11.fasta

my $file = $ARGV[0];

if($file !~ /(\.fasta|\.fa|\.fna)$/){
    die "Input file must be fasta-formatted ending in .fasta, fa, or .fna $!"
  }

open(FASTA, '<', $file) || die "Can't find fasta file, $file $!";

my @name = ();
my $i = 0;

while(<FASTA>)
{
  if($_ =~ /^>/)
  {
      my $header = $_;
      #simple remove demon character
      $header =~ tr/\t\n//d;
      chomp $header;
	if($header !~ /^>Contig/i)
	{
	    $header =~ s/^(>)/$1Contig/;
	    print $header, "\n";
	}
      $header = $header."\n";
      my $cc = index($header, '_') || index($header, '|');
      $name[$i] = substr($header, 1, $cc - 1);
      my $file2 = $name[$i].".fasta";
      $i++;
      open DAT, '>>', "anonymousContigs/$file2" or die "Can't open anonymousContigs/$file2\n";
      printf DAT $header;
     
   }
  elsif($_ =~ /^(A|C|G|T|N)/)
  {
      $_ =~ tr/\t\n//d;
      chomp;
       printf DAT $_;
   }
}

printf DAT "\n";

close FASTA;
