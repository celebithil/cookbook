package Cookbook::Form::Recipe;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';


has '+item_class' => (default =>'Recipe',);

has_field 'recipe_name' => (
    type => 'Text',
    required => 1,
    label => 'Название блюда',
);


has_field 'type_id' => (
    type  => 'Select',
    label => 'Тип блюда',
);

has_field 'recipe'  => (
    type => 'TextArea',
    cols => 80, row => 25,
    required => 0,
    label => 'Рецепт',
    );

has_field 'submit' => (
    type => 'Submit',
    value => 'Ввести',
);

__PACKAGE__->meta->make_immutable;
no HTML::FormHandler::Moose;
1;
