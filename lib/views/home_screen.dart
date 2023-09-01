import 'package:flutter/material.dart';
import 'package:api_integration/views/products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Center(
          child: Text('API Integration'),
        ),
      ),
      body: const ProductsScreen(),
    );
  }
}
