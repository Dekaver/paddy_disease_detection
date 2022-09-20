import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/components/HomeTop.dart';
import 'package:paddy_disease_detection/components/Prediction.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;
    
    var height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeTop(),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // SizedBox(
                      //   width: width! * 0.05,
                      // ),
                      const Text(
                        "Currently Watched items",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const Spacer(),
                      Text("VIEW ALL", style: viewallstyle)
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .25 < 170 ? height * .25 : 170,
                  //height: height * .25 < 300 ? height * .25 : 300,
                  // child:
                  // ConstrainedBox(
                  //   constraints: BoxConstraints(maxHeight: 170, minHeight: height * .13),
                  child: ListView.builder(
                      itemBuilder: (context, index) => cities[index],
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0.0),
                      itemCount: cities.length,
                      scrollDirection: Axis.horizontal),
                ),
              ],
            ),
          ],
        ),
      ),
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
var viewallstyle =
    TextStyle(fontSize: 14, color: appTheme.primaryColor //Colors.teal
        );

const List<Prediction> cities = [
  Prediction(
    image: "assets/images/Kerman.png",
    name: "Kerman",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    discount: "58",
  ),
  Prediction(
    image: "assets/images/Mashhad.png",
    name: "Mashhad",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    discount: "58",
  ),
  Prediction(
    image: "assets/images/Tehran.png",
    name: "Tehran",
    monthyear: "Far 1399",
    oldprice: "258500",
    newprice: "150000",
    discount: "58",
  ),
];
