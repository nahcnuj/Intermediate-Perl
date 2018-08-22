#!/usr/bin/env perl

use strict;
use warnings;

use Regexp::Assemble;

my $ra = Regexp::Assemble->new;
$ra->add(map { chomp; "$_" } <>);

my $pattern = $ra->re;

print "Enter lines (Ctrl-D to end):\n";
while (my $line = <STDIN>) {
    if ($line =~ $pattern) {
        print "Match at line $. | $line";
    }
}
