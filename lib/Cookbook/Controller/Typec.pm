package Cookbook::Controller::Typec;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbook::Controller::Typec - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('typec') :CaptureArgs(0) {
    my ( $self,  $c ) = @_;  
    
}

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
        template => 'type/list.tt',
    );
}


sub add :Chained('base') :PathPart('add') :Args(0) {
	    my ( $self,  $c ) = @_;
	    $c->stash( template => 'type/add.tt',);
	      
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






=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
