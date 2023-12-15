import 'package:flutter/material.dart';

class PublicProductViewScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const PublicProductViewScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['product_name'])),
      body: ListView(
        children: [],
      ),
    );
  }
}
