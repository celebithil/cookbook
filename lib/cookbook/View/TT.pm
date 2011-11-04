package cookbook::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    ENCODING     => 'utf-8',
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
);

=head1 NAME

cookbook::View::TT - TT View for cookbook

=head1 DESCRIPTION

TT View for cookbook.

=head1 SEE ALSO

L<cookbook>

=head1 AUTHOR

Charlie &

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
