#!/usr/bin/env perl

use v5.12;
use strict;
use warnings;

#package Navigation;
package Navigation {
    our @point = (30, 40);

    sub hello_world {
        print "Hello, world!\n";
    }

    sub func {
        my @point = (1..10);

        print "@point\n";
        print "@Navigation::point\n";
    }

    {
        package Another;

        # Another package
    }

    # Navigation package
}

1;
