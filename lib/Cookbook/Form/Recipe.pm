package Cookbook::Form::Dish;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

has '+item_class' => (default =>'Dish',);

has_field 'dish_name' => (
    type => 'Text',
    required => 1,
    label => 'Тип блюда',
);

has_field 'type_id' => ( type => 'Select', widget => 'RadioGroup',
      options => [{ value => 0, label => 'No'}, { value => 1, label => 'Yes'} ] );

has_field 'recipe'  => ( type => 'TextArea', cols => 80, row => 25, required => 0 );

has_field 'submit' => (
    type => 'Submit',
    value => 'Ввести',
);

__PACKAGE__->meta->make_immutable;
no HTML::FormHandler::Moose;
1;
