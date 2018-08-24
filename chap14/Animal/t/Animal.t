use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Animal') or BAIL_OUT();
}

diag( "Testing Animal $Animal::VERSION, Perl $], $^X" );

ok(defined &Animal::speak, 'Animal::speak is defined');
ok(defined &Animal::sound, 'Animal::sound is defined');

{
    eval { Animal->sound() } or my $at = $@;
    like($at, qr/have to define sound()/, 'sound() dies');
}

{
    eval { Animal->speak() } or my $at = $@;
    like($at, qr/have to define sound()/, 'speak() dies');
}

package Foofle {
    use parent qw(Animal);
    sub sound { 'foof' }
}
ok( Foofle->speak, 'An Animal subclass works');

done_testing();
