import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/components/HomeTop.dart';
import 'package:paddy_disease_detection/components/PredictionListCell.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/model/entity/prediction.dart';

class HomeScreen extends StatelessWidget {
  final PredictionDao dao;

  const HomeScreen({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(1),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green.shade50),
              child: Text("paddy"),
            ),
            ListTile(
                title: Text("Home"),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, '/'),
                    }),
            ListTile(
                title: Text("Camera"),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, '/camera'),
                    }),
            ListTile(
                title: Text("Data"),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, '/data'),
                    }),
            ListTile(
                title: Text("About"),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, '/data'),
                    }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
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
                        "Brown Spot",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      // Text("VIEW ALL",
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color:
                      //           Color.fromARGB(255, 57, 176, 39), //Colors.teal
                      //     ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .25 < 170 ? height * .25 : 170,
                  child: StreamBuilder<List<Prediction>>(
                    stream: dao.findPredictionByCategory("Brown spot"),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Bacterial Leaf Blight",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      // Text("VIEW ALL",
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color:
                      //           Color.fromARGB(255, 57, 176, 39), //Colors.teal
                      //     ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .25 < 170 ? height * .25 : 170,
                  child: StreamBuilder<List<Prediction>>(
                    stream: dao.findPredictionByCategory("Bacterial L. B."),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Leaf Smut",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Spacer(),
                      // Text("VIEW ALL",
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color:
                      //           Color.fromARGB(255, 57, 176, 39), //Colors.teal
                      //     ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .25 < 170 ? height * .25 : 170,
                  child: StreamBuilder<List<Prediction>>(
                    stream: dao.findPredictionByCategory("Leaf smut"),
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
