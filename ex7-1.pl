#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use File::Find;
use Time::Local;

my $target_dow = 1;        # Sunday is 0, Monday is 1, ...
my @starting_directories = (".");

my $seconds_per_day = 24 * 60 * 60;
my($sec, $min, $hour, $day, $mon, $yr, $dow) = localtime;
my $start = timelocal(0, 0, 0, $day, $mon, $yr);        # midnight today

while ($dow != $target_dow) {
  # Back up one day
  $start -= $seconds_per_day;        # hope no DST! :-)
  if (--$dow < 0) {
    $dow += 7;
  }
}
my $stop = $start + $seconds_per_day;

my($gather, $yield)  = gather_mtime_between($start, $stop);
find($gather, @starting_directories);
my @files = $yield->(  );

for my $file (@files) {
  my $mtime = (stat $file)[9];        # mtime via slice
  my $when = localtime $mtime;
  print "$when: $file\n";
}

sub gather_mtime_between {
  my $start_time = shift;
  my $end_time = shift;

  my @found_files;

  return (
    sub {
      # $_ is a file name, $File::Find::name is a path to file from starting directory
      my $timestamp = (stat $_)[9]; # stat takes a file name
      unless (defined $timestamp) { # e.g. when target file of a link is not found
        warn "Could not stat $File::Find::name: $!, skipping\n";
        return;
      }
      push @found_files, $File::Find::name if $start_time <= $timestamp and $timestamp <= $end_time;
    },
    sub {
      @found_files
    }
  );
}
