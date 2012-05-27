package Cookbook::Controller::Recipe;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Recipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched Cookbook::Controller::Recipe in recipe.');
}

# Просмотр рецепта
sub view : Local {
    my ( $self, $c, $id ) = @_;
    $c->stash( dish => $c->model('CookbookDB::Dish')->find($id) );
}

# Вывод формы для редактирования рецепта
sub edit : Local {
    my ( $self, $c, $id ) = @_;
    my $dish   = $c->model('CookbookDB::Dish')->find($id);
    my $recipe = $dish->recipe;
    $recipe =~ s/<br>/\n/g;
    $c->stash(
        dish => $dish,
        type => [
            $c->model('CookbookDB::Type')
              ->search( {}, { order_by => 'type_name' } )->all
        ],
        current_type => $c->model('CookbookDB::Type')
          ->find( { 'dishes.type_id' => $id }, { join => 'dishes' } ),
        recipe => $recipe,
    );

}

# Запись в базу измененного рецепта
sub update : Local {
    my ( $self, $c, $id ) = @_;
    my $p = $c->request->params;
    
    # Проверка на подтверждение редактирования
    if (defined $p->{submit}) {
        $p->{recipe} =~ s/\n/<br>/g;
        my $row = $c->model('CookbookDB::Dish')->find($id)->update(
            {
                dish_name => $p->{dish_name},
                type_id   => $p->{type_id},
                recipe    => $p->{recipe},
            }
        );
    }
    $c->response->redirect('/');
}

# Вывод формы для добавления нового рецепта
sub add : Local {
    my ( $self, $c ) = @_;
    $c->stash(
        type  => [ $c->model('CookbookDB::Type')->all ],
    );
}

# Добавление нового рецепта в базу
sub insert : Local {
    my ( $self, $c ) = @_;
    my $p = $c->request->params;

    # если подтверджения нет, то выводится список рецептов
    if (defined $p->{submit}) {
    # Если рецепт или его имя не введены, то добавления не происходит
    # форма добавление выводится заново
        unless ( $p->{dish_name} && $p->{recipe} ) {
            $c->response->redirect('/recipe/add');
            return;
        }

        # Добавление нового рецепта в базу
        else {
            $p->{recipe} =~ s/\r\n/<br>/g;
            $c->model('CookbookDB::Dish')->create(
                {
                    dish_name => $p->{dish_name},
                    type_id   => $p->{type_id},
                    recipe    => $p->{recipe},
                }
            );
        }
        
    }
    $c->response->redirect('/');
}

# запрос на удаление записи из базы
sub delete_form :Path('delete') Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash(
        template => 'recipe/delete.tt',
        dish => $c->model('CookbookDB::Dish')->find($id));
}

# удаление записи из базы
sub delete : Local Args(0) {
    my ($self, $c) = @_;
    my $p = $c->request->params;

    if (defined $p->{submit}) {
        $c->model('CookbookDB::Dish')->find($p->{id})->delete;
    }
    $c->response->redirect('/');
}


=head1 AUTHOR

Daniil Popov

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
