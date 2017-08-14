package Alien::pdf2htmlEX;
# ABSTRACT: Alien package for the pdf2htmlEX PDF-to-HTML conversion tool.

use strict;
use warnings;

use base qw( Alien::Base );
use Role::Tiny::With qw( with );

with 'Alien::Role::Dino';

use File::Spec;

=method pdf2htmlEX_path

Returns a C<Str> which contains the absolute path
to the C<pdf2htmlEX> binary.

=cut
sub pdf2htmlEX_path {
	my ($self) = @_;
	File::Spec->catfile( File::Spec->rel2abs($self->dist_dir) , qw(bin pdf2htmlEX) );
}


1;
