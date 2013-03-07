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
    my $rs = $c->model('CookbookDB::Recipe')->search(
        {},
        {
            columns  => [qw /name id/],
            join     => 'type',
            prefetch => 'type',
            order_by => 'me.name',
            rows     => PAGE_ROWS,
            page     => 1,
        }
    );
    $c->stash(
        recipes => $rs,
        pages   => [ $rs->pager->first_page .. $rs->pager->last_page ],
    );
}


# получение объекта по id
sub id : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    
    $c->stash( recipe => $c->model('CookbookDB::Recipe')->find($id) );
        unless ($c->stash->{recipe}) {
		     $c->response->body('record not found');
		     $c->response->status(404);
	    }
    }

# добавление рецепта
sub add : Chained('base') : PathPart('add') : Args(0) {
    my ( $self, $c ) = @_;
    
    $c->stash(
        recipe => $c->model('CookbookDB::Recipe')->new_result( {} ) 
    );
    
    return $self->form($c);
}

# просмотр рецепта
sub view : Chained('id') : PathPart('view') : Args(0) {
    my ( $self, $c ) = @_;
    
    $c->stash( 
		template    => 'recipe/view.tt'
	);
}

# удаление рецепта
sub delete : Chained('id') : PathPart('delete') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{recipe}->delete;
    
    $c->response->redirect( $c->uri_for( $self->action_for('list') ) );
}

# изменение рецепта
sub edit : Chained('id') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    
    return $self->form($c);
}

# Постраничный вывод
sub page : Local : Args(1) {
    my ( $self, $c, $page ) = @_;
    
    $page //= 1;
    
    my $rs = $c->model('CookbookDB::Recipe')->search(
        {},
        {
            columns  => [qw /name id/],
            join     => 'type',
            prefetch => 'type',
            order_by => 'me.name',
            rows     => PAGE_ROWS,
            page     => $page,
        }
    );
    
    $c->stash(
        recipes  => $rs,
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
        item   => $c->stash->{recipe},
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
