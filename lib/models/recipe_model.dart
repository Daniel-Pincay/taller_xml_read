

import 'package:read_three_xml/models/ingredient_model.dart';
import 'package:read_three_xml/models/step_model.dart';

class RecipeModel {
  final String tipo;
  final String difficult;
  final List<IngredientModel> ingredients;
  final int calories;
  final String url;
  final String time;
  final String elaboration;
  final List<StepModel> steps;
  final String name;

  const RecipeModel({
    this.name='',
    this.calories=0,
    this.difficult='',
    this.elaboration='',
    this.ingredients=const [],
    this.steps=const [],
    this.time='',
    this.tipo='',
    this.url=''
  });
}