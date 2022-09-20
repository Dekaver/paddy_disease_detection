import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    await cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<String?> takePicture() async {
    try {
      XFile file = await cameraController.takePicture();
      return file.path;
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (_, snapshoot) => (snapshoot.connectionState ==
                ConnectionState.done)
            ? Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 70, 30, 0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height /
                            cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
                      Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.only(top: 50),
                          child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.resolveWith(
                                    (states) => const CircleBorder()),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.blue.shade200),
                              ),
                              onPressed: () async {
                                if (!cameraController.value.isTakingPicture) {
                                  String? result = await takePicture();
                                  Navigator.pop(context, result);
                                }
                              },
                              child: const Text('')))
                    ],
                  ),
                ],
              )
            : const Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 20,
                  height: 20,
                ),
              ),
      ),
    );
  }
}
