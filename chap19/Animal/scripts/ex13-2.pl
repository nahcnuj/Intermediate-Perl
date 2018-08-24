#!/usr/bin/env perl
use v5.10.1;
use strict;
use warnings;

use Cow;
use Horse;
use Sheep;
use Mouse;

print "Tell me animals living in your bokujo:\n";

while (<STDIN>) {
    chomp;
    $_ = "\L\u$_";
    /^(Cow|Horse|Sheep|Mouse)$/ or do {
        warn "I don't know what does it cry.\n";
        next;
    };
    $_->speak();
}
