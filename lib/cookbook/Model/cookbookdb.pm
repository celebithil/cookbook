package cookbook::Model::cookbookdb;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'cookbook::Schema::cookbookdb',
    
    connect_info => {
        dsn => 'dbi:mysql:cookbook',
        user => 'root',
        password => 'solid',
        quote_names => q{1},
    }
);

=head1 NAME

cookbook::Model::cookbookdb - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<cookbook>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<cookbook::Schema::cookbookdb>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.55

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
