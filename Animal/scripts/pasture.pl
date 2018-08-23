use Cow;
use Horse;
use Sheep;

my @pasture = qw(Cow Cow Horse Sheep Sheep);
for my $beast (@pasture) {
    $beast->speak;
}
