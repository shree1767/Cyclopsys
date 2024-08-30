import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import './preview.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color(0xFF111915),
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),
        onMediaCaptureEvent: (event) {
          if (event.isPicture) {
            switch (event.status) {
              case MediaCaptureStatus.capturing:
                debugPrint('Capturing picture...');
                break;
              case MediaCaptureStatus.success:
                event.captureRequest.when(
                  single: (single) {
                    final filePath = single.file?.path;
                    if (filePath != null) {
                      debugPrint('Picture saved: $filePath');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewPage(imagePath: filePath),
                        ),
                      );
                    }
                  },
                );
                break;
              case MediaCaptureStatus.failure:
                debugPrint('Failed to capture picture: ${event.exception}');
                break;
              default:
                debugPrint('Unknown event: $event');
            }
          }
        },
      ),
    );
  }
}