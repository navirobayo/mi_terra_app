import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://as1.ftcdn.net/v2/jpg/00/66/93/76/1000_F_66937645_p9FK0kXiwslUc4Sdxo2xJJIQpsbLFI0u.jpg"),
                          ),
                        ),
                      ),
                      const Text("Acelgas"),
                      const Text("\$8000 libra. 8 Disponibles"),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Editar"),
                      IconButton(onPressed: null, icon: Icon(Icons.edit)),
                      Text("Eliminar"),
                      IconButton(onPressed: null, icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://as1.ftcdn.net/v2/jpg/06/28/98/30/1000_F_628983007_ot4QbSRTc1RrJMdjSHHyf0VeBMbV5PiC.jpg"),
                          ),
                        ),
                      ),
                      const Text("Espinacas"),
                      const Text("\$8000 libra. 8 Disponibles"),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Editar"),
                      IconButton(onPressed: null, icon: Icon(Icons.edit)),
                      Text("Eliminar"),
                      IconButton(onPressed: null, icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
