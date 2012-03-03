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
    my $dish  = $c->model('CookbookDB::Dish')->find($id);
    my $recipe = $dish->recipe;
    $recipe =~  s/<br>/\n/g;
    $c->stash(
	dish =>  $dish,
        type => [ $c->model('CookbookDB::Type')->search({},{order_by => 'type_name'})->all ],
        current_type => $c->model('CookbookDB::Type')->find(
        { 'dishes.type_id' => $id},
        {join => 'dishes'} 
        ),
        recipe => $recipe,
    );

}

# Запись в базу измененного рецепта
sub update : Local {
    my ( $self, $c, $id ) = @_;
    my $dish_name = $c->request->params->{dish_name};
    my $type_id   = $c->request->params->{type_id};
    my $recipe    = $c->request->params->{recipe};
    $recipe =~ s/\n/<br>/g;
    my $row       = $c->model('CookbookDB::Dish')->find($id)->update(
        {
            dish_name => $dish_name,
            type_id   => $type_id,
            recipe  => $recipe
        }
    );
    $c->stash( message => 'Запись изменена', recipe => $recipe );
}

# Вывод формы для добавления нового рецепта
sub add : Local {
    my ( $self, $c ) = @_;
    $c->stash(
        type  => [ $c->model('CookbookDB::Type')->all ],
        title => "Добавить запись"
    );
}

# Добавление нового рецепта в базу
sub insert : Local {
    my ( $self, $c ) = @_;
    my $dish_name = $c->request->params->{dish_name};
    my $type_id   = $c->request->params->{type_id};
    my $recipe    = $c->request->params->{recipe};
    # Если рецепт или его имя не введены, то добавления не происходит
	# форма добавление выводится заново
	unless ( $dish_name && $recipe ) {
        $c->stash(
            dish_name => $dish_name,
            recipe    => $recipe,
            type      => [
                $c->model('CookbookDB::Type')->all],
                template => 'recipe/add.tt2',
        );
    }
    # Добавление нового рецепта в базу
	else {
	$recipe =~ s/\r\n/<br>/g;
        $c->model('CookbookDB::Dish')->create(
            {
                dish_name => $dish_name,
                type_id   => $type_id,
                recipe  => $recipe
            }
        );
        $c->stash(
            template => 'recipe/after_insert.tt2',
            message  => 'Запись добавлена'
        );
    }
}

# удаление записи из базы
sub del : Local {
    my ( $self, $c, $id ) = @_;
    $c->model('CookbookDB::Dish')->find($id)->delete;
    $c->stash( message => 'Запись удалена' );
}

=head1 AUTHOR

Daniil Popov

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
