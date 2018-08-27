use Test::More;
use Test::My::List::Util;

use My::List::Util qw(sum);

my $sum = My::List::Util::sum(2, 2);
sum_ok($sum, 4, 'The sums match');

done_testing();
