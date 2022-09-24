
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:paddy_disease_detection/components/HomeTop.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';

class HomeScreen extends StatelessWidget {
  final PredictionDao dao;

  const HomeScreen({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    var height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            const HomeTop(),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Currently Watched items",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      Text("VIEW ALL",
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Color.fromARGB(255, 57, 176, 39), //Colors.teal
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .25 < 170 ? height * .25 : 170,
                  child: StreamBuilder<List<Prediction>>(
                    stream: dao.findAllPredictionsAsStream(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) return Container();

                      final predictions = snapshot.requireData;

                      return ListView.builder(
                        itemCount: predictions.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(0.0),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return PredictionListCell(
                            prediction: predictions[index],
                            dao: dao,
                          );
                        },
                      );
                    },
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

class PredictionListCell extends StatelessWidget {
  final Prediction prediction;
  final PredictionDao dao;

  const PredictionListCell({
    Key? key,
    required this.prediction,
    required this.dao,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.shortestSide;
    var height = MediaQuery.of(context).size.longestSide;
    return Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: height * .137 < 160 ? height * .137 : 160,
                    width: width * .5 < 250 ? width * .5 : 250,
                      child: Image.memory(
                        const Base64Decoder().convert(prediction.image),
                        fit: BoxFit.cover,)
                    // decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage(""),
                    //         fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  height: 60,
                  width: width * .5 < 250 ? width * .5 : 250,
                  left: 5,
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
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.black.withOpacity(.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              prediction.name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              prediction.category,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          prediction.score.toString() + "%",
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
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Text('${(newprice)}',
        //         style: const TextStyle(
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold,
        //             fontStyle: FontStyle.italic)),
        //     SizedBox(
        //       width: width * 0.08,
        //     ),
        //     Text('${(oldprice)}',
        //         style: const TextStyle(
        //             color: Colors.black87,
        //             fontWeight: FontWeight.w400,
        //             fontStyle: FontStyle.italic)),
        //   ],
        // )
      ],
    );
  }
}
// const List<Prediction> cities = [
//   Prediction(
//     image: "assets/images/Kerman.png",
//     name: "Kerman",
//     monthyear: "Far 1399",
//     oldprice: "258500",
//     newprice: "150000",
//     discount: "58",
//   ),
//   Prediction(
//     image: "assets/images/Mashhad.png",
//     name: "Mashhad",
//     monthyear: "Far 1399",
//     oldprice: "258500",
//     newprice: "150000",
//     discount: "58",
//   ),
//   Prediction(
//     image: "assets/images/Tehran.png",
//     name: "Tehran",
//     monthyear: "Far 1399",
//     oldprice: "258500",
//     newprice: "150000",
//     discount: "58",
//   ),
// ];
