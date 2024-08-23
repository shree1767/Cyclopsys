import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preview Image',
          style: TextStyle(
            color: Colors.white, 
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox.shrink(),
        backgroundColor: Color(0xFF111915),
      ),
      body: Center(
        child: Image.file(File(imagePath)), 
      ),
    );
  }
}