import 'dart:async';
import 'package:floor/floor.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Prediction])
abstract class AppDatabase extends FloorDatabase {
  PredictionDao get predictionDao;
}