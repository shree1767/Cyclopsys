import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './preview.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      setState(() {
        isCameraInitialized = true;
      });
    });
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: image.path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Document',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16, 
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color(0xFF111915), 
      ),
      body: isCameraInitialized
          ? SizedBox.expand(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: _takePicture,
          backgroundColor: Color(0xFF936BF8), 
          elevation: 6, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Fully circular button
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 233, 7, 7),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white, // Border color
                width: 2, // Border width
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Center the button at the bottom
    );
  }
}
