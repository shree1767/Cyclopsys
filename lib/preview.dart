import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String text = "";
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    getImageToText();
  }

  // Speak the extracted text
Future<void> _speakText() async {
  if (text.isNotEmpty) {
    try {
      // Remove punctuation and other symbols from the extracted text
      final cleanedText = text.replaceAll(RegExp(r'[^\w\s]'), '');

      // Ensure the text is not empty after cleaning
      if (cleanedText.isNotEmpty) {
        await flutterTts.setLanguage('en-US');
        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.speak(cleanedText);
      } else {
        print("No valid text to speak after cleaning.");
      }
    } catch (e) {
      print("Error while trying to speak text: $e");
    }
  } else {
    print("No text available to speak.");
  }
}

  // OCR Text extraction
  Future<void> getImageToText() async {
    try {
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(InputImage.fromFilePath(widget.imagePath));

      setState(() {
        text = recognizedText.text;
      });

      _showTextPopup();
    } catch (e) {
      print("Error during OCR: $e");
      setState(() {
        text = 'Error occurred while recognizing text.';
      });
    }
  }

  // Popup with a TTS option
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
            TextButton(
              onPressed: () {
                _speakText(); // Call TTS to speak the text
              },
              child: const Text('Speak Text'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when the page is disposed
    super.dispose();
  }

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
