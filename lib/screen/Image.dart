import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease_detection/Core/classifier_quant.dart';
import 'package:paddy_disease_detection/Core/classify.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/screen/Camera.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart' as helper;
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

class ImageFile extends StatefulWidget {
  final PredictionDao dao;
  const ImageFile({Key? key, required this.dao}) : super(key: key);

  @override
  State<ImageFile> createState() => _ImageFileState();
}

class _ImageFileState extends State<ImageFile> {
  File? _image;
  late Classifier _classifier;
  helper.Category? category;
  bool takePicture = false;
  String path = '';
  File imageFile = File('assets/images/Kerman.png');
  ImagePicker picker = ImagePicker();

  var date = "";
  double time = 0;
  String prediction = "";
  double percent = 0;
  // String? _retrieveDataError;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant(numThreads: 3);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    // print(pred.label);
    // print(pred.score);
    setState(() {
      prediction = pred.label;
      percent = double.parse((pred.score * 100).toStringAsFixed(4));
      category = pred;
    });
  }

  void _savePredict(int? id, String name, String image, double score, double time, String category) async {
    final pred = Prediction(id, name, image, score, time, category);
    await widget.dao.insertPrediction(pred);
    final res = await widget.dao.findPredictionById(1);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    var width = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    var formatter = DateFormat('dd-mm-yyyy');
    String datenow = formatter.format(now);

    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 300,
                height: 450,
                color: Colors.grey.shade200,
                child: (takePicture)
                    ? Image.file(imageFile)
                    : const SizedBox(
                        child: Center(
                          child: Text("No Image"),
                        ),
                      ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.shade200),
                ),
                onPressed: () async {
                  path = (await Navigator.push<String?>(context,
                      MaterialPageRoute(builder: (_) => const CameraPage())))!;
                  setState(() {
                    if (path != '') {
                      imageFile = File(path);
                      _image = imageFile;
                      takePicture = true;
                    } else {
                      takePicture = false;
                    }
                  });
                },
                child: const Text('Camera'),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.shade200),
                ),
                onPressed: () async {
                  XFile? fileimage =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    if (fileimage?.path != null) {
                      path = fileimage!.path;
                      imageFile = File(path);
                      _image = imageFile;
                      takePicture = true;
                    } else {
                      takePicture = false;
                    }
                  });
                },
                child: const Text('Galery'),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.shade200),
                ),
                onPressed: () {
                  final pres = DateTime.now().millisecondsSinceEpoch;
                  _predict();
                  final pre = DateTime.now().millisecondsSinceEpoch - pres;
                  setState(() {
                    time = pre.toDouble();
                  });
                },
                child: const Text('Scan'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: height * .137 < 160 ? height * .137 : 160,
                            width: width * .5 < 250 ? width * .5 : 250,
                            child: (takePicture)
                                ? RotatedBox(
                                    quarterTurns: 1,
                                    child:
                                        Image.file(imageFile, fit: BoxFit.fill))
                                : const SizedBox(
                                    child: Center(
                                      child: Text("No Image"),
                                    ),
                                  ),
                            // decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //         image: AssetImage("assets/images/Kerman.png"),
                            //         fit: BoxFit.fill)),
                          ),
                          Positioned(
                            height: 60,
                            width: width * .5 < 250 ? width * .5 : 250,
                            left: 0,
                            //right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.black, Colors.black12],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                            ),
                          ),
                          Positioned(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  //decoration: BoxDecoration(
                                  //   shape: BoxShape.rectangle,
                                  //   color: Colors.black.withOpacity(.4),
                                  //  borderRadius: BorderRadius.all(Radius.circular(10))
                                  // ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        prediction,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        date,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "$percent %",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            left: 10,
                            bottom: 10,
                            right: 15,
                          )
                        ],
                      )),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey.shade200),
                    ),
                    onPressed: () async {
                      List<int> imageBytes = imageFile.readAsBytesSync();
                      String base64Image = base64Encode(imageBytes);
                      _savePredict(
                          null, 'name', base64Image, percent, time, prediction);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
