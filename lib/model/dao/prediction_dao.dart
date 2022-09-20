import 'package:floor/floor.dart';

import '../entity/prediction.dart';

@dao
abstract class PredictionDao {
  @Query('SELECT * FROM Prediction')
  Future<List<Prediction>> findAllPredictions();

  @Query('SELECT * FROM Prediction WHERE id = :id')
  Stream<Prediction?> findPredictionById(int id);

  @insert
  Future<void> insertPrediction(Prediction person);
}