use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('LivingCreature') or BAIL_OUT();
}

diag( "Testing LivingCreature $LivingCreature::VERSION, Perl $], $^X" );

ok(defined &LivingCreature::speak, 'LivingCreature::speak is defined');
ok(defined &LivingCreature::sound, 'LivingCreature::sound is defined');

{
    eval { LivingCreature->sound() } or my $at = $@;
    like($at, qr/Not implemented/, 'sound() dies');
}

{
    eval { LivingCreature->speak() } or my $at = $@;
    like($at, qr/Not implemented/, 'speak() dies');
}

package Foofle {
    use parent qw(LivingCreature);
    sub sound { 'foof' }
}
ok(Foofle->speak, 'An LivingCreature subclass works');

done_testing();
