import 'package:floor/floor.dart';

@entity
class Prediction {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String image;
  final double score;
  final double time;
  final String category;
  

  Prediction(this.id, this.name, this.image, this.score, this.time, this.category);

   @override
  String toString() {
    return 'Prediction{id: $id, name: $name, path: $image, score: $score, time: $time, category: $category}';
  }

}