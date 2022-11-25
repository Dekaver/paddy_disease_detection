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
      print(percent);
      category = pred;
    });
  }

  void _savePredict(int? id, String name, String image, double score,
      double time, String category) async {
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
                onPressed: () async {
                  List<int> imageBytes = imageFile.readAsBytesSync();
                  String base64Image = base64Encode(imageBytes);
                  _savePredict(
                      null, 'name', base64Image, percent, time, prediction);
                },
                child: const Text('Save'),
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
        ],
      ),
    );
  }
}
