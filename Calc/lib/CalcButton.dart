import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final int textColor;
  final double textSize;
  final Function callback;

  const CalcButton({
    this.text,
    this.textColor,
    this.textSize = 28,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 65,
        height: 65,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () {
            callback(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w400,
            ),
          ),
          color: Colors.teal[50],
          textColor: Color(textColor),
        ),
      ),
    );
  }
}
