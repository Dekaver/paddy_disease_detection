import 'package:floor/floor.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';

@dao
abstract class PredictionDao {
  @Query('SELECT * FROM Prediction')
  Future<List<Prediction>> findAllPredictions();

  @Query('SELECT * FROM Prediction')
  Stream<List<Prediction>> findAllPredictionsAsStream();

  @Query('SELECT * FROM Prediction WHERE id = :id')
  Stream<Prediction?> findPredictionById(int id);

  @insert
  Future<void> insertPrediction(Prediction prediction);

  @delete
  Future<void> deletePrediction(Prediction prediction);


}