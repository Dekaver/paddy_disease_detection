import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/components/BottomNavigationBar.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/screen/home.dart';
import 'screen/Deals.dart';
import 'screen/Image.dart';
import 'db/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final dao = database.predictionDao;
  runApp(PaddyPredictionApp(
    dao: dao,
  ));
}

class PaddyPredictionApp extends StatelessWidget {
  final PredictionDao dao;
  const PaddyPredictionApp({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNav(
          appTheme: ThemeData(
              primaryColor: const Color.fromARGB(255, 57, 176, 39),
              secondaryHeaderColor: const Color.fromARGB(255, 243, 219, 33)),
          sel: 0,
          bodies: [
            HomeScreen(dao: dao),
            ImageFile(dao: dao),
            Deals(dao: dao),
            PredictionsListView(dao: dao),
            // const ScanPage()
          ]),
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 57, 176, 39),
          secondaryHeaderColor: const Color.fromARGB(255, 243, 219, 33)),
      title: "Paddy Disease Prediction",
    );
  }
}
