import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';

class Deals extends StatelessWidget {
  final PredictionDao dao;

  const Deals({Key? key, required this.dao}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const Text("data"),
          PredictionsListView(
            dao: dao,
          ),
        ],
      ),
    );
  }
}

class PredictionsListView extends StatelessWidget {
  final PredictionDao dao;

  const PredictionsListView({
    Key? key,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Prediction>>(
        stream: dao.findAllPredictionsAsStream(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return Container();

          final predictions = snapshot.requireData;

          return ListView.builder(
            itemCount: predictions.length,
            itemBuilder: (_, index) {
              return PredictionListCell(
                prediction: predictions[index],
                dao: dao,
              );
            },
          );
        },
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
    return Dismissible(
      key: Key('${prediction.hashCode}'),
      background: Container(
        padding: const EdgeInsets.only(left: 16),
        color: Colors.green,
        child: const Align(
          child: Text(
            'Change status',
            style: TextStyle(color: Colors.white),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Align(
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
          alignment: Alignment.centerRight,
        ),
      ),
      direction: DismissDirection.horizontal,
      child: ListTile(
        title: Text(prediction.name),
        subtitle: Text('Status: ${prediction.category}'),
        trailing: Text(prediction.score.toString()),
      ),
      confirmDismiss: (direction) async {
        String? statusMessage;
        switch (direction) {
          case DismissDirection.endToStart:
            await dao.deletePrediction(prediction);
            statusMessage = 'Removed Prediction';
            break;
          case DismissDirection.startToEnd:
            // final predictionsLength = .values.length;
            // final nextIndex = (predictionsLength + Prediction.type.index + 1) % PredictionsLength;
            // final PredictionCopy = Prediction.copyWith(type: .values[nextIndex]);
            // await dao.updatePrediction(PredictionCopy);
            // statusMessage = 'Updated Prediction status by: ${PredictionCopy.type.title}';
            break;
          default:
            break;
        }

        if (statusMessage != null) {
          final scaffoldMessengerState = ScaffoldMessenger.of(context);
          scaffoldMessengerState.hideCurrentSnackBar();
          scaffoldMessengerState.showSnackBar(
            SnackBar(content: Text(statusMessage)),
          );
        }
        return statusMessage != null;
      },
    );
  }
}
