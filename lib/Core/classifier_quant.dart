import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'classify.dart';

class ClassifierQuant extends Classifier {
  ClassifierQuant({int numThreads = 1}) : super(numThreads: numThreads);

  @override
  String get modelName => 'model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 255);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}