use strict;
use warnings;

use Test::More;

BEGIN {
    require_ok('My::List::Util') || BAIL_OUT();
}

diag("Testing My::List::Util $My::List::Util::VERSION, Perl $], $^X");

ok(defined &My::List::Util::shuffle, 'My::List::Util::shuffle is defined');

{
    my @orig = (1..10);
    my @shuffled = My::List::Util::shuffle(@orig);
    is(scalar @shuffled, scalar @orig, 'List length is not changed between before and after of shuffling');
    is("@{[sort(@shuffled)]}", "@{[sort(@orig)]}", 'All elements are the same ignoring the order');
    isnt("@shuffled", "@orig", 'Some elements are swapped');
}

{
    my @orig = qw(hoge fuga piyo);
    my @shuffled = My::List::Util::shuffle(@orig);
    is(scalar @shuffled, scalar @orig, 'List length is not changed between before and after of shuffling');
    is("@{[sort(@shuffled)]}", "@{[sort(@orig)]}", 'All elements are the same ignoring the order');
    isnt("@shuffled", "@orig", 'Some elements are swapped');
}

is_deeply([My::List::Util::shuffle()], [], 'shuffle() returns empty list');
is(My::List::Util::shuffle(undef), undef, 'shuffle(undef) returns undef');

done_testing();
