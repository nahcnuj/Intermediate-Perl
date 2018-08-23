#!/usr/bin/env perl

use strict;
use warnings;

chdir '/etc';
while (1) {
    print "Enter a regular expression: ";
    chomp(my $pattern = <STDIN>);
    if ($pattern eq '') {
        last;
    }

    print map { "$_\n" } grep { eval { /$pattern/ } } <* .*>;
    if ($@) {
        print "Error: $@";
    }
}
