package Cookbook::Controller::Recipe;
use Moose;
use namespace::autoclean;
use constant { PAGE_ROWS => 5 };
use Cookbook::Form::Recipe;

has 'edit_form' => (
    isa     => 'Cookbook::Form::Recipe',
    is      => 'rw',
    lazy    => 1,
    default => sub { Cookbook::Form::Recipe->new }
);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Recipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/') : PathPart('recipe') : CaptureArgs(0) { }

# Список всех записей
sub list : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my $rs = $c->model('CookbookDB::Dish')->search(
        {},
        {
            columns  => [qw /dish_name dish_id/],
            join     => 'type',
            prefetch => 'type',
            order_by => 'dish_name',
            rows     => PAGE_ROWS,
            page     => 1,
        }
    );
    $c->stash(
        dishs => $rs,
        pages => [ $rs->pager->first_page .. $rs->pager->last_page ],
    );
}

# получение объекта по id
sub id : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash( recipe => $c->model('CookbookDB::Dish')->find($id) );
}

sub add : Chained('base') : PathPart('add') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( recipe => $c->model('CookbookDB::Dish')->new_result( {} ) );
    return $self->form($c);
}

# Просмотр рецепта
sub view : Chained('id') : PathPart('view') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(template => 'recipe/view.tt');
}


sub delete : Chained('id') : PathPart('delete') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{recipe}->delete;
    $c->response->redirect( $c->uri_for( $self->action_for('list') ) );
}

sub edit : Chained('id') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    return $self->form($c);
}


# Постраничный вывод
sub page : Local : Args(1) {
    my ( $self, $c, $page ) = @_;
    $page //= 1;
    my $rs = $c->model('CookbookDB::Dish')->search(
        {},
        {
            columns  => [qw /dish_name dish_id/],
            join     => 'type',
            prefetch => 'type',
            order_by => 'dish_name',
            rows     => PAGE_ROWS,
            page     => $page,
        }
    );
    $c->stash(
        dishs    => $rs,
        pages    => [ $rs->pager->first_page .. $rs->pager->last_page ],
        template => 'recipe/list.tt',
    );
}

sub form {
    my ( $self, $c ) = @_;
    my $form = Cookbook::Form::Recipe->new;
    $c->stash( form => $form, template => 'recipe/form.tt' );
    return
      unless $form->process(
        item   => $c->stash->{dish},
        params => $c->req->parameters
      );
    $c->res->redirect( $c->uri_for( $self->action_for('list') ) );
}

=head1 AUTHOR

Daniil Popov

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
