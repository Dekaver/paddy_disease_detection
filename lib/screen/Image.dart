import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_disease_detection/Core/classifier_quant.dart';
import 'package:paddy_disease_detection/Core/classify.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart' as helper;
import 'package:image/image.dart' as img;

class ImageFile extends StatefulWidget {
  static const routeName = '/image';

  final PredictionDao dao;
  final String path;
  const ImageFile({
    Key? key,
    required this.dao,
    required this.path,
  }) : super(key: key);

  @override
  State<ImageFile> createState() => _ImageFileState();
}

class _ImageFileState extends State<ImageFile> {
  late File imageFile;
  late Classifier _classifier;
  helper.Category? category;
  double time = 0;
  String prediction = "";
  double percent = 0;
  // String? _retrieveDataError;

  void _predict() async {
    await _classifier.loadModel();
    if (_classifier.done) {
      final pres = DateTime.now().millisecondsSinceEpoch;
      img.Image imageInput = img.decodeImage(imageFile.readAsBytesSync())!;
      var pred = _classifier.predict(imageInput);
      final pre = DateTime.now().millisecondsSinceEpoch - pres;
      setState(() {
        prediction = pred.label;
        percent = double.parse((pred.score * 100).toStringAsFixed(4));
        category = pred;
        time = pre.toDouble();
      });
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    print(widget.path);
    _classifier = ClassifierQuant(numThreads: 3);
    imageFile = File(widget.path);
    _predict();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _savePredict(int? id, String name, String image, double score,
      double time, String category) async {
    final pred = Prediction(id, name, image, score, time, category);
    await widget.dao.insertPrediction(pred);
    // final res = await widget.dao.findPredictionById(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Container(
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
                    child: Image.file(File(widget.path))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  width: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 96,
                            child: Text("Prediction : "),
                          ),
                          Container(
                            width: 200,
                            child: Text(prediction),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 96,
                            child: Text("Accuracy : "),
                          ),
                          Container(
                            width: 200,
                            child: Text(percent.toString() + "%"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 96,
                            child: Text("Time : "),
                          ),
                          Container(
                            width: 200,
                            child: Text(time.toString() + 'ms'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green.shade200),
                    ),
                    onPressed: () async {
                      List<int> imageBytes = imageFile.readAsBytesSync();
                      String base64Image = base64Encode(imageBytes);
                      String name =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      _savePredict(null, "PREDICTION_" + name, base64Image,
                          percent, time, prediction);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageScreenArguments {
  final PredictionDao dao;
  final String path;

  ImageScreenArguments({required this.dao, required this.path});
}
