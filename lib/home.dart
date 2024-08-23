import 'package:flutter/material.dart';
import './camera.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFFFFF), backgroundColor: const Color(0xFF936BF8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                textStyle: const TextStyle(fontSize: 14), 
              ),
              child: const Text('Scan Document'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Tutorial'),
                      content: const Text('This is where the tutorial will be.'),
                      actions: [
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
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFFFFF), backgroundColor: const Color(0xFF303235), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                textStyle: const TextStyle(fontSize: 14), 
                side: const BorderSide(
                  color: Color.fromARGB(255, 105, 105, 105), 
                  width: 1,
                ),
              ),
              child: const Text('Walkthrough ?'),
            ),
          ],
        ),
      ),
    );
  }
}