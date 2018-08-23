#!/usr/bin/env perl

use strict;
use warnings;

require Oogaboogoo;

print map { (Oogaboogoo::number_to_day_name($_), "\n") } 0..6;

print map { (Oogaboogoo::number_to_month_name($_), "\n") } 0..11;

Oogaboogoo::number_to_day_name(7);
