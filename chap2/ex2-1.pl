#!/usr/bin/env perl

use strict;
use warnings;

use Cwd;
use File::Spec;

my $cur_dir = getcwd;
for (<* .*>) {
  chomp;
  my $abs_path = File::Spec->rel2abs($_, $cur_dir);
  print "    ${abs_path}\n";
}
