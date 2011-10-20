package cookbook::Controller::recipe;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

cookbook::Controller::recipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched cookbook::Controller::recipe in recipe.');
}

sub view : Local {
    my ( $self, $c, $id ) = @_;
    $c->stash( dish => $c->model('cookbookdb::Dish')->find($id) );
}

sub edit : Local {
    my ( $self, $c, $id ) = @_;
    $c->response->body("edit #$id");
}

sub add : Local {
    my ( $self, $c ) = @_;
    $c->stash(
        type  => [ $c->model('cookbookdb::Type')->all ],
        title => "Добавить запись"
    );
}

sub insert : Local {
    my ( $self, $c ) = @_;
    my $dish_name = $c->request->params->{dish_name};
    my $type_id   = $c->request->params->{type_id};
    my $recipe    = $c->request->params->{recipe};
    unless ( $dish_name && $recipe ) {
        $c->stash(
            dish_name => $dish_name,
            recipe    => $recipe,
            type      => [ $c->model('cookbookdb::Type')->all ]
        );
    }
    else {
        $c->model('cookbookdb::Dish')->create(
            {
                dish_name => $dish_name,
                type_id   => $type_id,
                receipt   => $recipe
            }
        );
        $c->stash(
            template => 'recipe/after_insert.tt2',
            message  => 'Запись добавлена'
        );
    }
}

sub del : Local {
    my ( $self, $c, $id ) = @_;
    $c->model('cookbookdb::Dish')->find($id)->delete;
    $c->stash( message => 'Запись удалена' );

    #$c->response->body("delete #$id");
}

=head1 AUTHOR

Daniil Popov

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
