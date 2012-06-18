package Cookbook::Form::Type;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'Books' );
has_field 'type_name';
has_field 'submit' => ( type => 'Submit', value => 'Ввести' );
has_field 'cancel' => ( type => 'Submit', value => 'Отменить' );

__PACKAGE__->meta->make_immutable;
1;
