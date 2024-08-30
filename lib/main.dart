import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Camera and Audio recording permissions
  await _requestPermissions();
  
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  var cameraStatus = await Permission.camera.status;
  var microphoneStatus = await Permission.microphone.status;

  if (!cameraStatus.isGranted) {
    await Permission.camera.request();
  }
  
  if (!microphoneStatus.isGranted) {
    await Permission.microphone.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyclopsys',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF111915)),
      home: const MyHomePage(),
    );
  }
}