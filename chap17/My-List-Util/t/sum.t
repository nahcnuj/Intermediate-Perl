use strict;
use warnings;

use Test::More;

BEGIN {
    require_ok('My::List::Util') || BAIL_OUT();
}

diag("Testing My::List::Util $My::List::Util::VERSION, Perl $], $^X");

ok(defined &My::List::Util::sum, 'My::List::Util::sum is defined');

is(My::List::Util::sum(1, 4, 2, 8), 15, 'sum(1, 4, 2, 8) returns 15');
is(My::List::Util::sum(-2..5), 12, 'sum(-2..5) returns 12');
is(My::List::Util::sum(-1..1), 0, 'sum(-1..1) returns 0');
is(My::List::Util::sum(qw(2 4.3 14.6)), 20.9, 'sum works against string looking like numeric');
is(My::List::Util::sum(3.14), 3.14, 'sum(3.14) returns 3.14');

is(My::List::Util::sum(), undef, 'sum() returns undef');
is(My::List::Util::sum(undef), undef, 'sum(undef) returns undef');
is(My::List::Util::sum(qw(a b c)), undef, 'Returns undef if there is no numeric value in list');

done_testing();
