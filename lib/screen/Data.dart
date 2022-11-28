import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';
import 'package:paddy_disease_detection/screen/Detail.dart';

class Data extends StatelessWidget {
  final PredictionDao dao;

  const Data({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: Text("Data")),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder<List<Prediction>>(
                      stream: dao.findAllPredictionsAsStream(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) return Container();

                        final predictions = snapshot.requireData;

                        return ListView.builder(
                          shrinkWrap: true,
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
                  ),
                ],
              )
            ],
          ),
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
      child: TextButton(
        onPressed: () => {
          Navigator.pushNamed(context, '/detail',
              arguments: DetailScreenArguments(prediction: prediction))
        },
        child: ListTile(
          title: Text(prediction.name),
          subtitle: Text('Status: ${prediction.category}'),
          trailing: Text(prediction.score.toString()),
        ),
      ),
      confirmDismiss: (direction) async {
        String? statusMessage;
        switch (direction) {
          case DismissDirection.endToStart:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Warning !"),
                  content: Text("Are you sure you want to delete it?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                    TextButton(
                      child: Text("Continue"),
                      onPressed: () async {
                        await dao.deletePrediction(prediction);
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                  ],
                );
              },
            );
            break;
          case DismissDirection.startToEnd:
            Navigator.pushNamed(context, '/detail',
                arguments: DetailScreenArguments(prediction: prediction));
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
