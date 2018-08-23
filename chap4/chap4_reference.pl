#!/usr/bin/env perl

use Carp qw(croak);
use Scalar::Util qw(reftype);

use strict;
use warnings;

sub check {
    # check(who, ref to array of whos_items)
    my $who = shift;
    my $items = shift;  # reference to array of items

    my %whos_items = map { $_, 1 } @$items;

    my @required = qw{preserver sunscreen water_bottle jacket};
    my @missing_items = ();

    for my $item (@required) {
        unless ( $whos_items{$item} ) {
            print "$who is missing $item.\n";
            push @missing_items, $item;
        }
    }

    if (@missing_items) {
        print "Add @missing_items to @$items for $who\n";
        push @$items, @missing_items;
    }
}

sub is_hash_ref {
    my $hash_ref = shift;
    return eval { keys %$hash_ref; 1 };
}

sub show_hash {
    my $hash_ref = shift;   # expect reference of hash
    #my $ref_type = ref $hash_ref;
    my $ref_type = reftype $hash_ref;  # can apply to object
    croak "I expected a hash reference!"
        unless is_hash_ref $hash_ref;

    for my $key ( %$hash_ref ) {
        print "$key\n";
    }
}

# reference to array
if (0) {
    my @skipper = qw{blue_shirt hat jacket preserver sunscreen};
    my @skipper_with_name = ('Skipper' => \@skipper);

    my @professor = qw{sunscreen water_bottle slide_rule};
    my @professor_with_name = ('Professor' => \@professor);

    my @gilligan = qw{red_shirt hat lucky_socks water_bottle};
    my @gilligan_with_name = ('Gilligan' => \@gilligan);

    my @all_with_names = (
        \@skipper_with_name,
        \@professor_with_name,
        \@gilligan_with_name,
    );

    #print "Gillgan has ${${$all_with_names[2]}[1]}[0]\n";
    #print "Gillgan has ${$all_with_names[2]}[1]->[0]\n";
    #print "Gillgan has $all_with_names[2]->[1]->[0]\n";
    print "Gillgan has $all_with_names[2][1][0]\n";

    my $root = \@all_with_names;
    print "Gillgan has $root->[2][1][0]\n";

    print "Gillgan has @{$root->[2][1]}\n";

    for my $person (@all_with_names) {
        # $person is reference
        my $who = $$person[0];
        my $provisions_reference = $$person[1];
        #check($who, $provisions_reference);
        check(@$person);
        print "$who has @$provisions_reference now\n";
    }
    #check(@$_) for @all_with_names;
}

# reference to hash
if (0) {
    my %gilligan_info = (
        name => 'Gilligan',
        hat => 'white',
        shirt => 'red',
        position => 'First Mate',
    );
    my $ref_to_hash = \%gilligan_info;

    #print "$$ref_to_hash{'name'}\n";
    print "$ref_to_hash->{'name'}\n";
    print "$_\n" for keys %$ref_to_hash;

    print "@$ref_to_hash{qw(name hat)}\n"; # hash slice
}

# type check of references
if (1) {
    my %hash = ( 'hoge' => 10, 'fuga' => 30 );
    my @array = 1..10;
    #show_hash( \%hash );    # ok
    show_hash( \@array );   # oops!
}
