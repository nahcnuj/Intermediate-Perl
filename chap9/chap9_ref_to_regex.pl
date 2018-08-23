#!/usr/bin/env perl

use v5.10.1;
use strict;
use warnings;

use List::Util qw( first );
use Regexp::Assemble;
use Regexp::Common qw( net );

{
    print "Enter a pattern: ";
    chomp(my $pattern = <STDIN>);
    my $regex = eval { qr/$pattern/ };
    print "$regex\n";
}

my %patterns = (
    Gilligan => qr/(?:Willie )?Gilligan/,
    'Mary Ann' => qr/Mary Ann/,
    Ginger => qr/Ginger/,
    Professor => qr/(?:The )?Professor/,
    Skipper => qr/Skipper/,
    'A Howell' => qr/Mrs?. Howell/,
);

my $name = 'Ginger';

# for my $pattern (@patterns) {
#     if ($name =~ $pattern) {
#         say "Match! $pattern";
#         last;
#     }
# }

my ($match) = first { $name =~ $patterns{$_} } keys %patterns;
print "Matched $match\n" if $match;

my $position = rightmost(
    'There are Mrs. Howell, Ginger, and Gilligan & Ginger',
    @patterns{ sort keys %patterns }
);
print "$position\n";

sub rightmost {
    my ($string, @patterns) = @_;

    my $rightmost = -1;
    while (my ($i, $pattern) = each @patterns) {
        $position = $string =~ m/$pattern/ ? $-[0] : -1;
        $rightmost = $position if $position > $rightmost;
    }

    $rightmost;
}

my $howells = qr/Thurston|Mrs/;
my $tagalongs = qr/Ginger|Mary Ann/;
my $passengers = qr/$howells|$tagalongs/;
print "$passengers\n";

# use Regexp::Common qw(net);
print "$RE{net}{IPv4}";

# use Regexp::Assemble;
my $ra = Regexp::Assemble->new;
for ('Mr. Howell', 'Mrs. Howell', 'Mary Ann') {
    $ra->add("\Q$_");
}
print $ra->re;
