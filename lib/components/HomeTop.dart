import 'package:flutter/material.dart';
import 'package:paddy_disease_detection/components/Clipper.dart';
import 'package:paddy_disease_detection/main.dart';

class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
  var isFlightselected = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper(),
          child: Container(
            height: height * .40 < 320 ? height * .40 : 300, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height / 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                      const Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 16,
                ),
                const Text(
                  'Paddy desease detection',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.0375),
                // Container(
                //   width: 300,
                //   padding: EdgeInsets.symmetric(horizontal: 32.0),
                //   child: Material(
                //     elevation: 5.0,
                //     borderRadius: BorderRadius.all(Radius.circular(30)),
                //     child: TextField(
                //       controller: c,
                //       style: TextStyle(
                //         fontSize: 16.0,
                //         color: Colors.black,
                //       ),
                //       cursorColor: appTheme.primaryColor,
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           contentPadding: EdgeInsets.symmetric(
                //               horizontal: 32, vertical: 13),
                //           suffixIcon: Material(
                //             child: InkWell(
                //               child: Icon(
                //                 Icons.search,
                //                 color: Colors.black,
                //               ),
                //               onTap: () {
                //                 Navigator.push(context,
                //                     MaterialPageRoute(builder: (context) {
                //                   return SecondPage(
                //                       fromloc: locs[selectedloc],
                //                       toloc: c.text);
                //                 }));
                //               },
                //             ),
                //             elevation: 2.0,
                //             borderRadius: BorderRadius.all(Radius.circular(30)),
                //           )),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: height * 0.025,
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: <Widget>[
                //     InkWell(
                //       child: Choice(
                //           icon: Icons.camera_alt,
                //           text: "Camera",
                //           selected: isFlightselected, width: width,),
                //       onTap: () {
                //         setState(() {
                //           isFlightselected = true;
                //         });
                //       },
                //     ),
                //     SizedBox(
                //       width: width * 0.055,
                //     ),
                //     InkWell(
                //       child: Choice(
                //           icon: Icons.image_rounded,
                //           text: "Galeries",
                //           selected: !isFlightselected),
                //       onTap: () {
                //         setState(() {
                //           isFlightselected = false;
                //         });
                //       },
                //     )
                //   ],
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}
