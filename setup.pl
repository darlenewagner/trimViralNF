#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
use local::lib;
require "/usr/share/lmod/lmod/init/perl";
#use IPC::System::Simple qw( system );

my $current_dir = getcwd;
print "Creating folders, annotated\/, intermediate\/, messy_contigs\/, and blastn_output\/ in ",  $current_dir, ".\n";

sleep(1);

#print "The current permissions are: ", umask(), "\n";

if(-d $current_dir."\/annotated/")
  { 
     warn "Folder 'annotated\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/annotated/"){ print "Created annotated\/\n"; } else { warn "Unable to create annotated\/\n";}
      chmod 0755, $current_dir."\/annotated/";
  }

sleep(1);

if(-d $current_dir."\/intermediate")
  { 
     warn "Folder 'intermediate\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/intermediate"){ print "Created intermediate\/\n"; } else { warn "Unable to create intermediate\/\n";}
      chmod 0755, $current_dir."\/intermediate";
  }

sleep(1);

if(-d $current_dir."\/anonymousContigs/")
  { 
     warn "Folder 'anonymousContigs\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/anonymousContigs/"){ print "Created anonymousContigs\/\n"; } else { warn "Unable to create anonymousContigs\/\n";}
      chmod 0755, $current_dir."\/anonymousContigs/";
  }

sleep(1);

if(-d $current_dir."\/blastn_output/")
  { 
     warn "Folder 'blastn_output\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/blastn_output/"){ print "Created blastn_output\/\n"; } else { warn "Unable to create blastn_output\/\n";}
      chmod 0755, $current_dir."\/blastn_output/";
  }

sleep(1);

if(-e $current_dir."\/test_genomes.tar")
  {
      system("tar xvf test_genomes.tar");
     ## system("mv -v test_genomes\/*.fasta messy_contigs\/")
  }
else
 {
     warn "Archive, test_genomes.tar, not found.";
  }

##system("which perl");

my $nextflowy = `which nextflow`;

if($? == 0)
{
    print "Found nextflow path: $nextflowy\n";
}
else
{
    #module("load nextflow/24.04.2");
    system("./moduleWrapper.sh");
    $nextflowy = `which nextflow`;
    if($? == 0)
    {
	print "Found nextflow path: $nextflowy\n";
	#my $see = `/usr/share/lmod/lmod/libexec/lmod perl load nextflow/24.10.4`;
	#    system("$see");
    }
    else
    {
        print "Nextflow executable or path not found!\nExit status: $?\n";
    }
}


#system("which blastn");

exit;


