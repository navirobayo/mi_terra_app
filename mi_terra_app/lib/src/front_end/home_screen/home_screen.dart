import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/back_end/components/global_strings.dart';
import 'package:mi_terra_app/src/front_end/harvest_screen/harvest_screen.dart';
import 'package:mi_terra_app/src/front_end/settings_screen/settings_screen.dart';
import 'package:mi_terra_app/src/front_end/store_screen/store_screen.dart';
import 'package:mi_terra_app/src/front_end/tasks_screen/tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void addNewExpense(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Nuevo gasto"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const Text("Añadir"),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const Text("Cancelar"),
                  onTap: () {},
                )
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(appName + appVersion),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ));
                },
                icon: const Icon(Icons.settings))
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const StoreScreen(),
                          ));
                        },
                        child: const SizedBox(
                          width: 130,
                          height: 60,
                          child: Center(child: Text('Mi tienda')),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "Hola, $testUserName",
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
                        child: Center(child: Text('Inventario')),
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
                          builder: (context) => const TasksScreen(),
                        ));
                      },
                      child: const SizedBox(
                        width: 150,
                        height: 150,
                        child: Center(child: Text('Pendientes')),
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HarvestScreen(),
                        ));
                      },
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
                  Column(
                    children: [
                      Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        clipBehavior: Clip.hardEdge,
                        elevation: 3,
                        child: InkWell(
                          splashColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                          onTap: () {
                            addNewExpense(context);
                          },
                          child: const SizedBox(
                            width: 150,
                            height: 60,
                            child: Center(child: Text('Añadir gasto')),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        clipBehavior: Clip.hardEdge,
                        elevation: 3,
                        child: InkWell(
                          splashColor:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const StoreScreen(),
                            ));
                          },
                          child: const SizedBox(
                            width: 150,
                            height: 60,
                            child: Center(child: Text('Añadir venta')),
                          ),
                        ),
                      ),
                    ],
                  )
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
                        child: Center(child: Text('Mercado orgánico')),
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
                        child: Center(child: Text('Mis finanzas')),
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
