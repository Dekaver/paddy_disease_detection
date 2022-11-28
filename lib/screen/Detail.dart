import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Prediction prediction;
  const DetailPage({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          Container(
            width: 300,
            child: Image.memory(
              const Base64Decoder().convert(prediction.image),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Prediction",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text(
                      "That Image is: ",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: 100,
                    child: Text(
                      prediction.category,
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text(
                      "Score: ",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: 100,
                    child: Text(
                      prediction.score.toString(),
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text(
                      "Time: ",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: 100,
                    child: Text(
                      prediction.time.toString(),
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          ),
          Text(
            "Solution :",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
        ],
      ),
    );
  }
}

class DetailScreenArguments {
  final Prediction prediction;

  DetailScreenArguments({required this.prediction});
}
