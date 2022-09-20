import 'package:flutter/material.dart';
// import '../main.dart';

class Choice extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;
  final double width;
  const Choice({Key? key, this.icon, this.text, this.selected, required this.width}) : super(key: key);
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.white.withOpacity(.30),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: widget.width * .025,
          ),
          Text(
            widget.text!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}