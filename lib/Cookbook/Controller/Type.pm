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

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(
        types => [
            $c->model('CookbookDB::Type')->search(
                {},
                {
                    columns  => [qw /type_name type_id/],
                    order_by => 'type_name'
                }
            )
        ]
    );

}

sub delete_form : Local {
    my ( $self, $c, $id ) = @_;
    $c->model('CookbookDB::Type')->find($id)->delete;
    $c->stash( message => 'Запись удалена' );
}




# удаление записи из базы
sub delete : Local {
    my ( $self, $c, $id ) = @_;
    $c->model('CookbookDB::Type')->find($id)->delete;
    $c->stash( message => 'Запись удалена' );
}

# просмотр записи
sub view : Local {
    my ( $self, $c, $id ) = @_;
    $c->stash( type => $c->model('CookbookDB::Type')->find($id) );

    #$c->stash( message => $id );
}

# Вывод формы для добавления нового рецепта
sub add : Local {
    my ( $self, $c ) = @_;
    $c->stash( title => "Добавить запись", );
}

# Добавление нового рецепта в базу
sub insert : Local {
    my ( $self, $c ) = @_;
    my $type_name = $c->request->params->{type_name};

# Если имя типа не введено, то добавления не происходит
# форма добавление выводится заново
    unless ($type_name) {
        $c->stash(
            type_name => $type_name,
            template  => 'type/add.tt',
        );
    }

    # Добавление нового типа в базу
    else {
        $c->model('CookbookDB::Type')->create( { type_name => $type_name, } );
        $c->stash(
            template => 'type/after_insert.tt',
            message  => 'Запись добавлена'
        );
    }
}

sub edit : Local {
    my ( $self, $c, $id ) = @_;
    $c->stash( type => $c->model('CookbookDB::Type')->find($id), );
}

# Запись в базу измененного типа
sub update : Local {
    my ( $self, $c, $id ) = @_;
    my $type_name = $c->request->params->{type_name};
    my $type_id   = $c->request->params->{type_id};
    my $row       = $c->model('CookbookDB::Type')->find($id)->update(
        {
            type_name => $type_name,
            type_id   => $type_id,
        }
    );
    $c->stash( message => 'Запись изменена', type => $type_name );
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
