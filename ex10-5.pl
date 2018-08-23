#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

use Data::Dumper;
use File::Basename;
use File::Spec::Functions;

sub data_for_path_depth_first {
    my $path = shift;
    if (-f $path or -l $path) {
        undef;
    } elsif (-d $path) {
        my %directories;
        my @contents = do {
            opendir my $dh, $path or die "Could not open $path: $!";
            (readdir $dh);
        };
        +{ map {
            if ($_ ne '.' and $_ ne '..') {
                ($_ => data_for_path_depth_first("$path/$_"))
            } else {
                ()
            }
        } @contents };
    } else {
        warn "$path is neither a file nor a dir\n";
        undef;
    }
}

sub data_for_path_breadth_first {
    my $path = shift;

    my $data = {};
    my @queue = [ $path, $data ];

    while (my $next = shift @queue) {
        my ($path, $ref) = @$next;
        my $basename = basename $path;

        $ref->{$basename} = do {
            if (-f $path or -l $path) {
                undef;
            } elsif (-d $path) {
                my $hash = {};
                opendir my $dh, $path or die;
                my @new_paths =
                    map { catfile $path, $_ }
                    grep { ! /^\.\.?\z/ }
                    readdir $dh;
                unshift @queue, map { [$_, $hash] } @new_paths;
                $hash;
            } else {
                warn "$path is neither a file nor a dir\n";
                undef;
            }
        };
    }

    $data;
}

sub data_for_path {
    state $algorithm = {
        'depth-first' => \&data_for_path_depth_first,
        'breadth-first' => \&data_for_path_breadth_first,
    };
    my ($path, $way) = @_;
    $algorithm->{$way}->($path);
}

sub dump_data_for_path {
    my ($path, $data_ref, $level) = @_;

    my $basename = basename $path;
    print '  ' x $level, $basename;
    if (not defined $data_ref) {
        # file or symbolic link
        print "\n";
    } elsif ( keys %$data_ref ) {
        print ", with contents:\n";
        dump_data_for_path("$path/$_", $data_ref->{$_}, 1+$level) for sort keys %$data_ref;
    } else {
        print ", an empty directory\n";
    }
}

print dump_data_for_path('.', data_for_path('.', 'depth-first'), 0);

