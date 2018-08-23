#!/usr/bin/env perl

use strict;
use warnings;

# using require
require 'Navigation.pm';

sub hello_world {
    print "Hi, world!\n";
}

Navigation::hello_world();
Navigation::func();

if (0) {   # using eval
    sub load_common_subroutines {
        open my $more_fh, '<', 'Navigation.pm'
            or die "Could not load Navigation.pm: $!";
        undef $/;
        my $more_code = <$more_fh>;
        close $more_fh;
        eval $more_code;
        die $@ if $@;
    }

    load_common_subroutines();
    hello_world();
}

if (0) {   # using do
    do 'Navigation.pm';
    die $@ if $@;

    hello_world();
}
