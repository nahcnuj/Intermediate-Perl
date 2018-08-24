use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Animal') or BAIL_OUT();
}

diag( "Testing Animal $Animal::VERSION, Perl $], $^X" );

done_testing();
