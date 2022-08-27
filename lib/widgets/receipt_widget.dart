

import 'package:flutter/material.dart';
import 'package:read_three_xml/models/recipe_model.dart';

class ReceiptWidget extends StatelessWidget {
  const ReceiptWidget({Key? key, required this.recipes}) : super(key: key);
  final List<RecipeModel> recipes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (_, index){
        return Card(
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(  
                    recipes[index].url
                  ),
                ),
                title: Text(recipes[index].name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                subtitle: Text(recipes[index].calories.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                trailing: Text(recipes[index].difficult.toString(),
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            );
      }
    );
  }
}