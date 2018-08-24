package Animal;

use 5.006;
use strict;
use warnings;

use parent qw(LivingCreature);

use Carp qw(croak);

=head1 NAME

Animal - The great new Animal!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

An interface of all animals

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 named

Constructor.

=cut

sub named {
    my $class = shift;
    my $name = shift;
    my $self = {
        Name => $name,
        Color => $class->default_color,
    };
    bless $self, $class;
}

=head2 DESTROY

Destructor.

=cut

sub DESTROY {
    my $self = shift;
    print '[', $self->name, " has died.]\n";
}

=head2 set_name

Set Animal's name.

=cut

sub set_name {
    ref(my $self = shift) or croak "instance variable needed";
    my $name = shift;
    $self->{Name} = $name;
}

=head2 set_color

Set Animal's color.

=cut

sub set_color {
    ref(my $self = shift) or croak "instance variable needed";
    my $color = shift;
    $self->{Color} = $color;
}

=head2 name

Get Animal's name.

=cut

sub name {
    my $either = shift;
    ref $either
        ? $either->{Name}       # instance
        : "an unnamed $either"  # class
}

=head2 color

Get Animal's color.

=cut

sub color {
    my $either = shift;
    ref $either
        ? $either->{Color}
        : $either->default_color;
}

=head2 default_color

Get Animal's default color.

=cut

sub default_color { 'brown' }

=head2 speak

Let Animal speak

=cut

sub speak {
    my $class = shift;
    die "Animal can not speak!" if @_;
    print "A $class goes ", $class->sound, "!\n";
}

=head2 sound

Return sound of Animal.

=cut

sub sound {
    die 'You have to define sound() method in a subclass'
}

=head1 AUTHOR

Junichi Hayashi, C<< <j-hayashi at seesaa.co.jp> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-animal at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Animal>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Animal


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Animal>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Animal>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Animal>

=item * Search CPAN

L<https://metacpan.org/release/Animal>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Junichi Hayashi.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Animal
