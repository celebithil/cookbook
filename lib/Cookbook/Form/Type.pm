package Cookbook::Form::Type;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'Type' );
has_field 'type_name' => (type => 'Text', required => 1);
has_field 'submit' => ( type => 'Submit', value => 'Ввести' );
has_field 'cancel' => ( type => 'Submit', value => 'Отменить' );

__PACKAGE__->meta->make_immutable;
1;
