package Cookbook::Controller::Type;
use Moose;
use namespace::autoclean;
use Cookbook::Form::Type;

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


sub add :Chained('base') :PathPart('add') :Args(0) {
	    my ( $self,  $c ) = @_;
	    my $type = $c->model('CookbookDB::Type')->new_result({});
        return $self->form($c, $type);
	      
}

sub edit :Chained('base') :PathPart('edit') :Args(1) {
	    my ( $self,  $c ) = @_;	      
}

sub delete :Chained('base') :PathPart('delete') :Args(1) {
	    my ( $self,  $c ) = @_;	      
}

sub view :Chained('base') :PathPart('view') :Args(1) {
	    my ( $self,  $c ) = @_;	      
}


sub form {
        my ( $self, $c, $type ) = @_;

        my $form = Cookbook::Form::Type->new;
        # Set the template
        $c->stash( template => 'type/form.tt', form => $form );
        $form->process( item => $type, params => $c->req->params );
        return unless $form->validated;
        $c->flash( message => 'Type created' );
        # Redirect the user back to the list page
        $c->response->redirect($c->uri_for($self->action_for('list')));
    }





=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
