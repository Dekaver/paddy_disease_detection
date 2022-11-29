import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';

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
        Container(
          padding: EdgeInsets.all(3),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                        padding: EdgeInsets.all(0),
                        height: height * .137 < 160 ? height * .137 : 160,
                        width: width * .5 < 250 ? width * .5 : 250,
                        child: Image.memory(
                          const Base64Decoder().convert(prediction.image),
                          fit: BoxFit.cover,
                          alignment: AlignmentDirectional.center,
                          opacity: AlwaysStoppedAnimation<double>(1),
                        )),
                  ),
                  Positioned(
                    height: 30,
                    width: width * .5 < 250 ? width * .5 : 250,
                    left: 0,
                    //right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color.fromARGB(100, 0, 0, 0), Color.fromARGB(100, 0, 0, 0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                    ),
                  ),
                  Positioned(
                    height: 30,
                    width: width * .5 < 250 ? width * .5 : 250,
                    left: 0,
                    top: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Color.fromARGB(100, 0, 0, 0),
                            Color.fromARGB(100, 0, 0, 0)
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                  ),
                  Positioned(
                    height: 20,
                    left: 10,
                    top: 3,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      // decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     color: Colors.black.withOpacity(.8),
                      //     borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            prediction.name,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
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
        ),
      ],
    );
  }
}
