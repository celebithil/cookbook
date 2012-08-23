package Cookbook::Controller::Type;
use Moose;
use namespace::autoclean;
use Cookbook::Form::Type;

has 'edit_form' => ( isa => 'Cookbook::Form::Type', is => 'rw',
   lazy => 1, default => sub { Cookbook::Form::Type->new } );
has 'view_form' => ( isa => 'Cookbook::Form::TypeView', is => 'rw',
   lazy => 1, default => sub { Cookbook::Form::TypeView->new } );

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Type - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('type') :CaptureArgs(0) {}

sub list :Chained('base') :PathPart('') :Args(0) {
    my ( $self,  $c ) = @_;
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

sub id :Chained('base') :PathPart('') :CaptureArgs(1){
    my ( $self,  $c, $id) = @_;
    $c->stash(type => $c->model('CookbookDB::Type')->find($id));
}

sub add :Chained('base') :PathPart('add') :Args(0) {
    my ( $self,  $c ) = @_;
    $c->stash( type => $c->model('CookbookDB::Type')->new_result({}) );
    return $self->form($c);
}

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ( $self,  $c ) = @_;
    return $self->form($c);
}

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ( $self,  $c ) = @_;
    $c->stash->{type}->delete;
    $c->response->redirect($c->uri_for($self->action_for('list')));
}


sub view :Chained('base') :PathPart('view') :Args(1) {
	    my ( $self,  $c ) = @_;	      
}


sub form {
    my ( $self, $c ) = @_;
    my $form = Cookbook::Form::Type->new;
    $c->stash( form => $form, template => 'type/form.tt' );
    return unless $form->process(
        item => $c->stash->{type},
        params => $c->req->parameters
    );
    $c->res->redirect( $c->uri_for($self->action_for('list')) );
}





=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
