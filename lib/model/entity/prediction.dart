import 'package:floor/floor.dart';

@entity
class Prediction {
  @primaryKey
  final int id;
  final String name;
  final String path;
  final String score;
  final String time;
  final String category;
  

  Prediction(this.id, this.name, this.path, this.score, this.time, this.category);
}