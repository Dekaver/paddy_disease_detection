import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/components/BottomNavigationBar.dart';
import 'package:paddy_disease_detection/model/dao/prediction_dao.dart';
import 'package:paddy_disease_detection/screen/Camera.dart';
import 'package:paddy_disease_detection/screen/Detail.dart';
import 'package:paddy_disease_detection/screen/home.dart';
import 'screen/Data.dart';
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
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 57, 176, 39),
          secondaryHeaderColor: const Color.fromARGB(255, 243, 219, 33)),
      title: "Paddy Disease Prediction",
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(dao: dao),
        '/camera': (context) => CameraPage(dao: dao),
        '/data': (context) => Data(dao: dao),
        // '/detail': (context) => Detail(dao: dao),
      },
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == ImageFile.routeName) {
          final args = settings.arguments as ImageScreenArguments;
          return MaterialPageRoute(
            builder: (context) {
              return ImageFile(
                dao: args.dao,
                path: args.path,
              );
            },
          );
        }
        if (settings.name == DetailPage.routeName) {
          final args = settings.arguments as DetailScreenArguments;
          return MaterialPageRoute(
            builder: (context) {
              return DetailPage(
                prediction: args.prediction,
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
