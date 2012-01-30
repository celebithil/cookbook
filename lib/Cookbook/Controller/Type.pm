package Cookbook::Controller::Type;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Type - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(
        types => [
            $c->model('CookbookDB::Type')
              ->search( {}, { columns => [qw /type_name type_id/], order_by => 'type_name' } )
        ]
    );

}

# удаление записи из базы
sub del : Local {
    my ( $self, $c, $id ) = @_;
    $c->model('CookbookDB::Type')->find($id)->delete;
    $c->stash( message => 'Запись удалена' );
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
