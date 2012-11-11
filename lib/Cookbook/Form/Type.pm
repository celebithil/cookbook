package Cookbook::Form::Type;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';


has '+item_class' => (default =>'Type',);

has_field 'type_name' => (
    type => 'Text',
    required => 1,
    label => 'Тип блюда',
);


has_field 'submit' => (
    type => 'Submit',
    value => 'Ввести',
);

__PACKAGE__->meta->make_immutable;
no HTML::FormHandler::Moose;
1;

