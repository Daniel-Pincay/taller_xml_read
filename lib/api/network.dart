import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:read_three_xml/models/food_model.dart';
import 'package:read_three_xml/models/ingredient_model.dart';
import 'package:read_three_xml/models/plant_model.dart';
import 'package:read_three_xml/models/recipe_model.dart';
import 'package:read_three_xml/models/step_model.dart';
import 'package:xml/xml.dart' as xml;
class NetworkApi {

  Future<List<FoodModel>> getListFoods({required BuildContext context})async{
    List<FoodModel> foods =[];
    try{
      final xmlString = await DefaultAssetBundle.of(context).loadString('assets/comida.xml');
      final data=xml.XmlDocument.parse(xmlString);
      final elements=data.findAllElements('food');

      for (final element in elements) {
        foods.add(
          FoodModel(
            calories: int.tryParse(element.findElements('calories').first.text)??0,
            name: element.findElements('name').first.text,
            price:  element.findElements('price').first.text,
            url: element.findElements('url').first.text,
          )
        );
      }
      
    }catch(e){
      // inspect(e);
      foods=[];
    }

    return foods;
  }


  Future<List<PlantModel>> getListPlants({required BuildContext context})async{
    List<PlantModel> plants =[];
    try{
      final xmlString = await DefaultAssetBundle.of(context).loadString('assets/planta.xml');
      final data=xml.XmlDocument.parse(xmlString);
      final elements=data.findAllElements('PLANT');

      for (final element in elements) {
        // inspect(element.findElements('AVAILABILITY').first);
        plants.add(
          PlantModel(
            zone: int.tryParse(element.findElements('ZONE').first.text)??0,
            availability: element.findElements('AVAILABILITY').first.text.toString(),
            botanical: element.findElements('BOTANICAL').first.text,
            light: element.findElements('LIGHT').first.text,
            commom: element.findElements('COMMON').first.text,
            price:  element.findElements('PRICE').first.text,
            url: element.findElements('URL').first.text,
          )
        );
      }
      
    }catch(e){
      // inspect(e);
      plants=[];
    }

    return plants;
  }

  Future<List<RecipeModel>> getListRecipe({required BuildContext context})async{
    List<RecipeModel> recipes =[];
    try{
      final xmlString = await DefaultAssetBundle.of(context).loadString('assets/receta.xml');
      final data=xml.XmlDocument.parse(xmlString);
      final elements=data.findAllElements('receta');
      
      for (final element in elements) {
        List<StepModel> steps=[];
        List<IngredientModel> ingredients=[];
        xml.XmlAttribute def= element.findElements('tipo').first.attributes.firstWhere(
          (p0){
              return p0.name.toString()=='definicion';
            },
            orElse: () => xml.XmlAttribute(xml.XmlName('def'), 'error'),
          );
        
        Iterable<xml.XmlElement> stepsDyn=element.findElements('pasos');
       
        for (final stepXml in stepsDyn) {
              xml.XmlAttribute def= stepXml.findElements('paso').first.attributes.firstWhere(
              (p0){
                  return p0.name.toString()=='orden';
                },
                orElse: () => xml.XmlAttribute(xml.XmlName('orden'), 'error'),
              );
             
            steps.add(
              StepModel(
                description: stepXml.findElements('paso').first.text,
                step: int.tryParse(def.value.toString())??0
              )
            );
        }
        Iterable<xml.XmlElement> ingredientssDyn=element.findElements('ingredientes');
        
         for (final ingXml in ingredientssDyn.toList()) {
            inspect(ingXml.attributes);
              xml.XmlAttribute name= ingXml.findElements('ingrediente').first.attributes.firstWhere(
              (p0){
                  return p0.name.toString()=='nombre';
                },
                orElse: () => xml.XmlAttribute(xml.XmlName('nombre'), 'error'),
              );
              xml.XmlAttribute cantidad= ingXml.findElements('ingrediente').first.attributes.firstWhere(
              (p0){
                  return p0.name.toString()=='cantidad';
                },
                orElse: () => xml.XmlAttribute(xml.XmlName('cantidad'), 'error'),
              );
             
            ingredients.add(
              IngredientModel(
                cantidad: cantidad.value,
                name: name.value
              )
            );
        }
        // inspect(ingredients);

        recipes.add(
          RecipeModel(
            steps: steps,
            name: element.findElements('nombre').first.text,
            ingredients: ingredients,
            calories: int.tryParse(element.findElements('calorias').first.text)??0,
            difficult: element.findElements('dificultad').first.text,
            elaboration: element.findElements('elaboracion').first.text,
            time: element.findElements('tiempo').first.text,
            tipo: def.value,
            url: element.findElements('url').first.text,
          )
        );
      }
      
    }catch(e){
      inspect(e);
      recipes=[];
    }

    return recipes;
  }
}