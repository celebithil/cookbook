package cookbook::Controller::recipe;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

cookbook::Controller::recipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched cookbook::Controller::recipe in recipe.');
}

sub view :Local {
        my ( $self, $c, $id ) = @_;    
        $c->response->body("view #$id");
}

sub edit :Local {
        my ( $self, $c, $id ) = @_;    
        $c->response->body("edit #$id");
}


sub add :Local {
        my ( $self, $c) = @_;    
        $c->stash( title =>"Добавить запись");
}

sub del :Local {
        my ( $self, $c, $id ) = @_;    
        $c->response->body("delete #$id");
}



=head1 AUTHOR

Daniil Popov

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
