import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import './CalcButton.dart';

void main() {
  runApp(CalcApp());
}

class CalcApp extends StatefulWidget {
  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  String _history = '';
  String _expression = '';

  void numClick(String text) {
    setState(() => _expression += text);
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void delete(String text) {
    setState(
        () => _expression = _expression.substring(0, _expression.length - 1));
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();

    setState(() {
      _history = _expression;
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Calculator',
            style: TextStyle(color: Color(0xFF00BFA5), fontSize: 30),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          //padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    _history,
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF545F61),
                    ),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _expression,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.black,
                    ),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.teal[50]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CalcButton(
                          text: 'C',
                          textColor: 0xFF000000,
                          callback: allClear,
                        ),
                        CalcButton(
                          text: '⌫',
                          textColor: 0xFF000000,
                          callback: delete,
                        ),
                        CalcButton(
                          text: '%',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '/',
                          textColor: 0xFF00BFA5,
                          callback: numClick,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CalcButton(
                          text: '7',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '8',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '9',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '*',
                          textColor: 0xFF00BFA5,
                          textSize: 24,
                          callback: numClick,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CalcButton(
                          text: '4',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '5',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '6',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '-',
                          textColor: 0xFF00BFA5,
                          textSize: 38,
                          callback: numClick,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CalcButton(
                          text: '1',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '2',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '3',
                          callback: numClick,
                          textColor: 0xFF000000,
                        ),
                        CalcButton(
                          text: '+',
                          textColor: 0xFF00BFA5,
                          textSize: 30,
                          callback: numClick,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CalcButton(
                          text: '00',
                          textColor: 0xFF000000,
                          callback: numClick,
                        ),
                        CalcButton(
                          text: '0',
                          callback: numClick,
                          textColor: 0xFF000000,
                        ),
                        CalcButton(
                          text: '.',
                          callback: numClick,
                          textColor: 0xFF000000,
                          textSize: 26,
                        ),
                        CalcButton(
                          text: '=',
                          textColor: 0xFF00BFA5,
                          callback: evaluate,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
