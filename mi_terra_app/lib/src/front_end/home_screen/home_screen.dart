import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/components/global_strings.dart';
import 'package:mi_terra_app/src/front_end/profit_screen/profit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Hola $testUserName"),
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.settings))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      clipBehavior: Clip.hardEdge,
                      elevation: 3,
                      child: InkWell(
                        splashColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        onTap: () {},
                        child: const SizedBox(
                          width: 130,
                          height: 60,
                          child: Center(child: Text('Nueva venta')),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    testConnectionStatusFalse,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Mi cosecha')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfitScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Ganancias')),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Mis animales')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 3,
                    child: InkWell(
                      splashColor: Theme.of(context).colorScheme.primary,
                      onTap: () {},
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Inventario')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
