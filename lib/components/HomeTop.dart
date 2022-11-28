import 'package:flutter/material.dart';
// import 'package:paddy_disease_detection/components/IconToggleButton.dart';
import 'package:paddy_disease_detection/components/Clipper.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper(),
          child: Container(
            height: height * .40 < 180 ? height * .40 : 200, //400
            //color: Colors.tealAccent,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 57, 176, 39),
              Color.fromARGB(255, 243, 219, 33)
            ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      // Icon(
                      //   Icons.location_on,
                      //   color: Colors.white,
                      // ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      const Spacer(),
                      
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                const Text(
                  'Paddy desease detection',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
              ],
            ),
          ),
        )
      ],
    );
  }
}
