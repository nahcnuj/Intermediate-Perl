#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use utf8;

use IO::Dir;
use IO::File;
use IO::Interactive qw( interactive );
use IO::Null;
use IO::Pipe;
use Storable qw( nstore_fd );

{
    open my $log_fh, '>>', 'castaway.log'
        or die "Could not open castaway.log: $!";
    
    # $_ is a default parameter for print
    $_ = 'hoge fuga piyo';
    print;
    print STDOUT;
    print STDERR;

    print $log_fh; #=> GLOB(0xHHHH)
    print { $log_fh } "Hello, world!\n";

    sub log_message {
        my $fh = shift;
        print $fh @_, "\n";
    }
    log_message($log_fh, 'hoge');
}

{
    open my $log_fh, '<', 'castaway.log'
        or die "Could not open castaway.log: $!";
    if ( -f $log_fh ) {
        print "file\n";
    } else {
        print "not file\n";
    }
}

{
    my @data = qw( hoge fuga piyo );
    open my $string_fh, '>', \ my $string;
    nstore_fd \@data, $string_fh;
    print "captured:\n$string\n";
}

print "\n";

my $multiline_string = "foo\nbar\nbaz\n";

if (0) {
    my @lines = split /$/, $multiline_string;
    for (@lines) {
        print;
    }
} else {
    open my $string_fh, '<', \$multiline_string;
    while (<$string_fh>) {
        print;
    }
}

if (@_) {
    while (<>) {
        state $fhs;

        my ($src, $dst, $bytes) = split;
        
        unless ( $fhs->{$src} ) {
            open my $fh, '>>', $src or die "Could not create file $src: $!";
            $fhs->{$src} = $fh;
        }

        say { $fhs->{$src} } "$dst $bytes";
    }
}

{
    #use IO::File;
    
    my $fh = IO::File->new('> castaway.log') or die "$!";

    my $read_fh = IO::File->new('castaway.log', 'r');
    my $write_fh = IO::File->new('castaway.log', 'w');

    my $append_fh = IO::File->new('castaway.log', O_WRONLY | O_APPEND);

    my $temp_fh = IO::File->new_tmpfile;
    $temp_fh->close;

    open my $tmp_fh, '+>', undef;
}

{
    #use IO::Pipe;
    #open my $pipe, '-|', 'perl -v' or die "Could not open pipe: $!";
    my $pipe = IO::Pipe->new;
    $pipe->reader("$^X -V");
    while (<$pipe>) {
        print;
    }
}

{
    #use IO::Pipe;
    #open my $pipe, "| cat" or die "Could not open pipe: $!";
    my $pipe = IO::Pipe->new;
    $pipe->writer("cat");
    for ( 1..10 ) {
        print $pipe "$_\n";
    }
}

{
    #use IO::Null;

    my $null_fh = IO::Null->new;
    print $null_fh "hello\n";
}

{
    #use IO::Interactive qw( interactive );

    print { interactive } "Now interactive\n";
}

{
    opendir my $dh, '.' or die "Could not opendir: $!";
    for my $file ( readdir($dh) ) {
        print "Found $file\n";
    }
}

{
    #use IO::Dir;
    my $dh = IO::Dir->new('.');
    while (defined(my $file = $dh->read)) {
        print "Found $file\n";
    }
}

## old way
if (0) {
    sub log_message {
        local *FH = shift;

        print FH @_, "\n";
    }

    open LOG_FH, '>>', 'castaway.log'
        or die "Could not open castaway.log: $!";
    
    log_message( *LOG_FH , 'Hello, world!' );
}
