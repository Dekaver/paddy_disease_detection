import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/screen/Image.dart';

late List<CameraDescription> cameras;

class CameraPage extends StatefulWidget {
  final PredictionDao dao;

  const CameraPage({Key? key, required this.dao}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;
  String path = '';
  ImagePicker picker = ImagePicker();
  File imageFile = File('assets/images/Kerman.png');
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
                        child: path == ''
                            ? CameraPreview(cameraController)
                            : Image.file(File(path)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
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
                                    XFile? fileimage = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (fileimage?.path != null) {
                                      setState(() {
                                        path = fileimage!.path;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.filter))),
                          Spacer(),
                          Container(
                              width: 70,
                              height: 70,
                              margin: const EdgeInsets.only(top: 50),
                              child: path == ''
                                  ? TextButton(
                                      style: ButtonStyle(
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    const CircleBorder()),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    Colors.blue.shade200),
                                      ),
                                      onPressed: () async {
                                        if (!cameraController
                                            .value.isTakingPicture) {
                                          String? result = await takePicture();
                                          print("object");
                                          setState(() {
                                            path = "$result";
                                          });
                                        }
                                      },
                                      child: Icon(Icons.camera))
                                  : TextButton(
                                      style: ButtonStyle(
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    const CircleBorder()),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    Colors.blue.shade200),
                                      ),
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, '/image',
                                            arguments: ImageScreenArguments(
                                                dao: widget.dao, path: path));
                                      },
                                      child: Icon(Icons.check_circle_outline))),
                          Spacer(),
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
                                  onPressed: () {
                                    if (path == '') {
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        path = "";
                                      });
                                    }
                                  },
                                  child: path == ''
                                      ? Icon(Icons.arrow_back)
                                      : Icon(Icons.cancel_outlined))),
                          Spacer()
                        ],
                      ),
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
