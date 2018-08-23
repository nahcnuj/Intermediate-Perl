#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use Data::Dump::Streamer;

sub skipper_greets {
    my $person = shift;
    print "Skipper: Hey, $person!\n";
}

sub gilligan_greets {
    my $person = shift;
    if ($person eq 'Skipper') {
        print "Gilligan: Sir, yes, sir, $person!\n";
    } else {
        print "Gilligan: Hi, $person!\n";
    }
}

sub professor_greets {
    my $person = shift;
    print "Professor: By my calc., your must be $person!\n";
}

my $ref_to_greeter = \&skipper_greets;
#&$ref_to_greeter('Gilligan');

#for my $greet (\&skipper_greets, \&gilligan_greets) {
#    $greet->('Professor');
#}

my %greets = (
    Gilligan => \&gilligan_greets,
    Skipper => \&skipper_greets,
    Professor => \&professor_greets
);

for my $person (qw(Skipper Gilligan)) {
    $greets{$person}->('Professor');
}

my $ginger = sub {
    my $person = shift;
    print "Ginger: Well hello, $person.\n";
};
$ginger->('Skipper');

use File::Find;
my $total_size = 0;
find(
    sub {
        print "$File::Find::name found\n";
        $total_size += -s if -f;
    },
    '.'
);
print $total_size, "\n";

{
    my $callback;
    {
        my $count = 0;
        $callback = sub {
            print ++$count, ": $File::Find::name\n";
        }
    }
    #$count; # no longer enable but...
    find($callback, '.');
}

{
    sub create_find_callback_that_counts {
        my $count = 0;
        return sub {
            print ++$count, ": $File::Find::name\n";
        };
    }

    my $callback = create_find_callback_that_counts();
    find($callback, '.');
}

{
    sub create_find_callback_that_sum_the_size {
        my $total_size = 0;
        return (
            sub { $total_size += -s if -f },
            sub { return $total_size }
        );
    }

    my %subs;
    for my $dir (qw(.)) {
        my ($callback, $getter) = create_find_callback_that_sum_the_size();
        $subs{$dir}{CALLBACK} = $callback;
        $subs{$dir}{GETTER} = $getter;
    }

    Dump %subs;

    for (keys %subs) {
        find($subs{$_}{CALLBACK}, $_);
    }

    for (sort keys %subs) {
        my $sum = $subs{$_}{GETTER}->();
        print "$_ has $sum bytes\n";
    }
}

{
    sub print_bigger_than {
        my $minimum_size = shift;
        return sub {
            print "$File::Find::name\n" if -f and -s >= $minimum_size
        };
    }

    my $bigger_than_1024 = print_bigger_than(1024);
    find($bigger_than_1024, '.');
}

use v5.10;
sub func {
    state $array_ref = [ 1..10 ];
    state $hash_ref = { hoge => 'fuga', foo => 'bar' };
    push @$array_ref, 20;
    $hash_ref->{'test'} = 'failed';
    print "@$array_ref ", sort(keys %$hash_ref), "\n";
}

func;
func;

use v5.16;
my $factorial = sub {
    state $n = 5;
    return unless $n >= 0;
    say $n--;
    __SUB__->();
};
$factorial->();
