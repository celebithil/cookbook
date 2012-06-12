package Cookbook::Controller::Recipe;
use Moose;
use namespace::autoclean;
use constant {
    PAGE_ROWS  => 5
};

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Recipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->redirect( '/recipe/list' );
}

# Список всех записей
sub list :Path :Args(0) {
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
        pages => [$rs->pager->first_page .. $rs->pager->last_page],
    );
}

# Просмотр рецепта
sub view :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash( dish => $c->model('CookbookDB::Dish')->find($id) );
}

# Вывод формы для редактирования рецепта
sub edit :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    my $dish   = $c->model('CookbookDB::Dish')->find($id);
    my $recipe = $dish->recipe;
    $recipe =~ s/<br>/\n/g;
    my $type = $c->model('CookbookDB::Type') ->search(
        {}, { order_by => 'type_name' } 
    );

    $c->stash(
        dish => $dish,
        types => $type,
        current_type => $dish->type_id,
        recipe => $recipe,
    );

}

# Запись в базу измененного рецепта
sub update :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $param = $c->request->params;
    
    # Проверка на подтверждение редактирования
    if ( $param->{submit} eq 'Изменить') {
        $param->{recipe} =~ s/\n/<br>/g;
        my $row = $c->model('CookbookDB::Dish')->find($param->{dish_id})->update({
                dish_name => $param->{dish_name},
                type_id   => $param->{type_id},
                recipe    => $param->{recipe},
        });
    }
    $c->response->redirect( '/recipe/list' );
}

# Вывод формы для добавления нового рецепта
sub add :Local :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(
        type  => [ $c->model('CookbookDB::Type')->all ],
    );
}

# Добавление нового рецепта в базу
sub insert :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $param = $c->request->params;

    # если подтверджения нет, то выводится список рецептов
    if ( $param->{submit} eq 'Ввести') {
    # Если рецепт или его имя не введены, то добавления не происходит
    # форма добавление выводится заново
        unless ( $param->{dish_name} && $param->{recipe} ) {
            $c->response->redirect( '/recipe/add' );
            return;
        }

        # Добавление нового рецепта в базу
        else {
            $param->{recipe} =~ s/\r\n/<br>/g;
            $c->model('CookbookDB::Dish')->create({
                    dish_name => $param->{dish_name},
                    type_id   => $param->{type_id},
                    recipe    => $param->{recipe},
            });
        }
    }
    $c->response->redirect( '/recipe/list' );
}

# запрос на удаление записи из базы
sub delete_form :Path('delete') :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash(
        template => 'recipe/delete.tt',
        dish => $c->model('CookbookDB::Dish')->find($id));
}

# удаление записи из базы
sub delete :Local :Args(0)  {
    my ($self, $c) = @_;
    my $param = $c->request->params;

    if ( $param->{submit} eq 'Да') {
        $c->model('CookbookDB::Dish')->find( $param->{id} )->delete;
    }
    $c->response->redirect( '/recipe/list' );
}

# Постраничный вывод
sub page :Local :Args(1) {
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

=head1 AUTHOR

Daniil Popov

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
