#!/usr/bin/env perl

use strict;
use warnings;

package Oogaboogoo;
use Exporter qw(import);
our @EXPORT_OK = qw(number_to_day_name number_to_month_name);

sub number_to_day_name {
    my $num = shift;
    qw(ark dip wap sen pop sep kir)[$num]
        or die "A argument should be between 0 and 6";
}

sub number_to_month_name {
    my $num = shift;
    qw(diz pod bod rod sip wax lin sen kun fiz nap dep)[$num]
        or die "A argument should be between 0 and 11";
}

1;
