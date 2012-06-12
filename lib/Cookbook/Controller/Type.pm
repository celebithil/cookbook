package Cookbook::Controller::Type;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Type - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->redirect( '/type/list' );
}

# список типов блюд
sub list :Path :Args(0) {
    my ( $self, $c ) = @_;
        my $rs = $c->model('CookbookDB::Type')->search(
            {},
            {
                columns  => [qw /type_name type_id/],
                order_by => 'type_name'
            }
        );
    $c->stash(
        types => $rs,
    );

}

# запрос на удаление записи из базы
sub delete_form :Path('delete') :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash(
        template => 'type/delete.tt',
        type => $c->model('CookbookDB::Type')->find($id));
}

# удаление записи из базы
sub delete :Local :Args(0) {
    my ($self, $c) = @_;
    my $param = $c->request->params;
    if ($param->{submit} eq 'Да') {
        $c->model('CookbookDB::Type')->find( $param->{id} )->delete;
    }
    $c->response->redirect('/type/list');
}

# просмотр записи
sub view :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash( type => $c->model('CookbookDB::Type')->find($id) );

}

# Вывод формы для добавления нового рецепта
sub add :Local :Args(0){
    my ( $self, $c ) = @_;
    $c->stash();
}

# Добавление нового рецепта в базу
sub insert :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $param = $c->request->params;
    # Проверка подтверждения
    if ( $param->{submit} eq 'Ввести' ) {
        # Если имя типа не введено, то добавления не происходит
        # форма добавление выводится заново
        unless ($param->{type_name}) {
            $c->response->redirect('/type/add');
            return;
        }
        # Добавление нового типа в базу
        else {
            $c->model('CookbookDB::Type')->create( { type_name => $param->{type_name}, } );
        }
    }
    $c->response->redirect('/type/list');

}

sub edit :Local :Args(1){
    my ( $self, $c, $id ) = @_;
    $c->stash( type => $c->model('CookbookDB::Type')->find($id), );
}

# Запись в базу измененного типа
sub update :Local :Args(0){
    my ( $self, $c ) = @_;
    my $param = $c->request->params;
    # Проверка подтверждения
    if ( $param->{submit} eq 'Изменить' ) {
        my $row = $c->model('CookbookDB::Type')->find( $param->{id} )->update({
            type_name => $param->{name},
        });
    }
    $c->response->redirect('/type/list');
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
