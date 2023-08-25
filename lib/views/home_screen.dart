import 'package:api_integration/views/photos_screen.dart';
import 'package:flutter/material.dart';

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
      body: PhotosScreen(),
    );
  }
}
