use strict;
use warnings;

use Test::More;
use Test::File;

if ($^O =~ /linux/) {
    my $file = '/etc/hosts';
    file_exists_ok($file);
    file_readable_ok($file);
} elsif ($^O =~ /MSWin32/) {
    my $file = 'C:\windows\system32\drivers\etc\hosts';
    file_exists_ok($file);
    file_readable_ok($file);
}

done_testing();
