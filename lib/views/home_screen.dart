import 'package:flutter/material.dart';
import 'package:api_integration/views/upload_image_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UploadImageScreen(),
    );
  }
}
