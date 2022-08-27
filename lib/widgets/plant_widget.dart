

import 'package:flutter/material.dart';
import 'package:read_three_xml/models/plant_model.dart';

class PlantWidget extends StatelessWidget {
  const PlantWidget({Key? key, required this.plants}) : super(key: key);
  final List<PlantModel> plants;

  @override
  Widget build(BuildContext context) {
   return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (_, index){
        return Card(
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(  
                    plants[index].url
                  ),
                ),
                title: Text(plants[index].botanical,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                subtitle: Text(plants[index].availability.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                trailing: Text(plants[index].price.toString(),
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            );
      }
    );
  }
}