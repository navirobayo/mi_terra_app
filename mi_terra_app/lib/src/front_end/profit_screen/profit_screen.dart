import 'package:flutter/material.dart';
import 'package:mi_terra_app/src/components/global_strings.dart';

class ProfitScreen extends StatefulWidget {
  const ProfitScreen({super.key});

  @override
  State<ProfitScreen> createState() => _ProfitScreenState();
}

class _ProfitScreenState extends State<ProfitScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Global:"),
                SizedBox(width: 20),
                Text("\$", style: TextStyle(fontSize: 48)),
                Text(testUserGlobalProfit, style: TextStyle(fontSize: 48)),
              ],
            ),
            Row(
              children: [
                Text("Última cosecha:"),
                SizedBox(width: 20),
                Text("\$", style: TextStyle(fontSize: 48)),
                Text(testUserLastHarvest, style: TextStyle(fontSize: 48)),
              ],
            )
          ],
        ),
      )),
    );
  }
}
