import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/components/BottomNavigationBar.dart';
import 'package:paddy_disease_detection/screen/home.dart';
import 'package:paddy_disease_detection/screen/scan.dart';
import 'screen/Camera.dart' as prefix0;
import 'screen/Deals.dart';
import 'screen/Image.dart';
import 'db/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final dao = database.predictionDao;

  runApp(const PaddyPredictionApp());
}

class PaddyPredictionApp extends StatelessWidget {
  const PaddyPredictionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNav(appTheme: appTheme, bodies: bodies, sel: sel),
      theme: appTheme,
      title: "Paddy Disease Prediction",
    );
  }
}

ThemeData appTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 57, 176, 39),
    /* Colors.tealAccent,*/
    secondaryHeaderColor:
        const Color.fromARGB(255, 243, 219, 33) /* Colors.teal*/
    // fontFamily:
    );

int sel = 0;
double? width;
double? height;
final bodies = [
  const HomeScreen(),
  const ImageFile(),
  const Deals(),
  const Deals(),
  // const ScanPage()
];

var selectedloc = 0;





