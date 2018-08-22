#!/usr/bin/env perl

use strict;
use warnings;

use IO::File;

my %file_handles;
while (<>) {
    my ($name) = /(.*):/;

    unless ($file_handles{$name}) {
        my $filename = "\L$name.info";
        $file_handles{$name} = IO::File->new($filename, '>')
            or die "Could not open $filename: $!";
    }

    print { $file_handles{$name} } "$_";
}
