package Cookbook::Controller::Root;
use Moose;
use namespace::autoclean;


BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

Cookbook::Controller::Root - Root Controller for cookbook

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

# Список всех записей
sub index : Path : Args(0) {
    my ( $self, $c) = @_;    
    my $rs = $c->model('CookbookDB::Dish') -> search( {}, { columns => [qw /dish_name dish_id/], join => 'type', prefetch => 'type', order_by => 'dish_name', rows => 5, page => 1} );
    my $pager = $rs -> pager;
    my $dishs = [$rs -> all];
    $c->stash( dishs => $dishs,  pages => [$pager->first_page..$pager ->last_page]);
}

sub page : Path : Args(1) {
    my ( $self, $c, $page) = @_;
    $page //= 1;    
    my $rs = $c->model('CookbookDB::Dish') -> search( {}, { columns => [qw /dish_name dish_id/], join => 'type', prefetch => 'type', order_by => 'dish_name', rows => 5, page => $page} );
    my $pager = $rs -> pager;
    my $dishs = [$rs -> all];
    $c->stash( dishs => $dishs,  pages => [$pager->first_page..$pager ->last_page], template => 'index.tt2');
}













=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
