import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:read_three_xml/api/network.dart';
import 'package:read_three_xml/models/food_model.dart';
import 'package:read_three_xml/models/option_model.dart';
import 'package:read_three_xml/models/plant_model.dart';
import 'package:read_three_xml/models/recipe_model.dart';
import 'package:read_three_xml/widgets/food_widget.dart';
import 'package:read_three_xml/widgets/receipt_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Listas Desde Xml'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<OptionModel> options=[
    const OptionModel(name: 'Comida', option: 0),
    const OptionModel(name: 'planta', option: 1),
    const OptionModel(name: 'receta', option: 2),
  ];
  int currentOptionSelected=2;
   List<dynamic>response=[];
   List<FoodModel>responseFood=[];
   List<RecipeModel>responseRecipe=[];
   List<PlantModel>responsePlants=[];
  final NetworkApi networkApi=NetworkApi();

  getInitData()async{
   
    try{
      if(currentOptionSelected==1){
         responsePlants=await networkApi.getListPlants(context: context);

      }else if(currentOptionSelected==2){
         responseRecipe=await networkApi.getListRecipe(context: context);

      }else{
        responseFood= await networkApi.getListFoods(context: context);
      }
      setState(() {
        
      });
      inspect(response.first);
    }catch(e){
      // inspect(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButtonFormField(
              items: options.map((e){
                return DropdownMenuItem(
                  value: e.option,
                  child: Text(e.name)
                );
              }).toList(), 
              onChanged: (int? option){
                if(option!=null){
                    currentOptionSelected=option;
                    getInitData();
                }
              }
            ),
             Expanded(  
            child: currentOptionSelected==0?
            FoodWidget(foods: responseFood):
            currentOptionSelected==2?
            ReceiptWidget(recipes: responseRecipe)
            :Container()
            ,
          )
          ],
         
        ),
      ),
    
    );
  }
}
