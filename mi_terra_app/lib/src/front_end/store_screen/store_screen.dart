import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).colorScheme.onBackground,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/mi-terra-app.appspot.com/o/terra_database%2FCaptura%20de%20pantalla%202023-12-06%20212051.png?alt=media&token=5c031e59-c48e-4b5c-9aeb-6e0b84c3ca08"),
                      ),
                    ),
                  ),
                  const Text("Espinacas"),
                  const Text("\$8000 libra. 8 Disponibles"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
