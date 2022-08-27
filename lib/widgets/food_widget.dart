

import 'package:flutter/material.dart';
import 'package:read_three_xml/models/food_model.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({Key? key, required this.foods}) : super(key: key);
  final List<FoodModel> foods;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (_, index){
        return Card(
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(  
                    foods[index].url
                  ),
                ),
                title: Text(foods[index].name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                subtitle: Text(foods[index].calories.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                trailing: Text(foods[index].price.toString(),
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            );
      }
    );
  }
}