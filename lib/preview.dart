import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  // ignore: library_private_types_in_public_api
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String text = "";

  @override
  void initState() {
    super.initState();
    getImageToText();
  }

  // OCR Text extraction
  Future<void> getImageToText() async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = 
      await textRecognizer.processImage(InputImage.fromFilePath(widget.imagePath));

    setState(() {
      text = recognizedText.text;
    });

    _showTextPopup();
  }

  // To be removed after TTS implementation
  void _showTextPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Extracted Text'),
          content: SingleChildScrollView(
            child: Text(text.isEmpty ? 'No text found.' : text),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
  //
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
        backgroundColor: const Color(0xFF111915),
      ),
      body: Center(
        child: Image.file(File(widget.imagePath)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}