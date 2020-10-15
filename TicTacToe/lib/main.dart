import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum GameState { RUNNING, X_WIN, O_WIN, DRAW }

class _MyHomePageState extends State {
  String _player = "X";

  static final int boardCnt = 9;
  GameState currentGameState = GameState.RUNNING;
  Map<String, Color> _boardColors;

  List boardStates = new List(boardCnt);

  _MyHomePageState() {
    _init();

    _boardColors = new Map();
    _boardColors['X'] = Colors.red[100];
    _boardColors['O'] = Colors.blue[100];
    _boardColors[''] = Colors.teal[100];
  }

  void _setBoardState(int index) {
    if (boardStates[index] != '' || currentGameState != GameState.RUNNING) {
      return;
    }
    setState(() {
      boardStates[index] = _player;
      if (_player == 'X') {
        _player = 'O';
      } else {
        _player = 'X';
      }
    });

    updateGameState();
  }

  void _clear() {
    setState(() {
      _init();
    });
  }

  void _init() {
    _player = 'X';

    for (int i = 0; i < boardStates.length; i++) {
      boardStates[i] = '';
    }

    currentGameState = GameState.RUNNING;
  }

  void updateGameState() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        String compared = boardStates[i * 3];
        bool equals = true;
        for (int j = 1; j < 3; j++) {
          if (compared != boardStates[i * 3 + j] ||
              boardStates[i * 3 + j] == '') {
            equals = false;
            break;
          }
        }

        if (equals) {
          if (compared == 'X') {
            currentGameState = GameState.X_WIN;
          } else {
            currentGameState = GameState.O_WIN;
          }
        }
      }

      for (int i = 0; i < 3; i++) {
        String compared = boardStates[i];
        bool equals = true;
        for (int j = 1; j < 3; j++) {
          if (compared != boardStates[i + j * 3] ||
              boardStates[i + j * 3] == '') {
            equals = false;
            break;
          }
        }

        if (equals) {
          if (compared == 'X') {
            currentGameState = GameState.X_WIN;
          } else {
            currentGameState = GameState.O_WIN;
          }
          return;
        }
      }

      bool equals = true;
      String compared = boardStates[0];

      for (int i = 0; i < 3; i++) {
        print((4 * i).toString() + '/' + compared + '/' + boardStates[4 * i]);

        if (compared != boardStates[4 * i] || boardStates[4 * i] == '') {
          equals = false;
          break;
        }
      }

      print(equals.toString());

      if (equals) {
        if (compared == 'X') {
          currentGameState = GameState.X_WIN;
        } else {
          currentGameState = GameState.O_WIN;
        }
        return;
      }

      equals = true;
      compared = boardStates[2];

      for (int i = 1; i <= 3; i++) {
        if (compared != boardStates[2 * i] || boardStates[2 * i] == '') {
          equals = false;
        }
      }

      if (equals) {
        if (compared == 'X') {
          currentGameState = GameState.X_WIN;
        } else {
          currentGameState = GameState.O_WIN;
        }
        return;
      }

      int notNullcount = boardStates.where((item) => item != '').length;

      if (notNullcount == boardCnt) {
        currentGameState = GameState.DRAW;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: _clear,
                icon: Icon(
                  Icons.refresh_outlined,
                  size: 30,
                ),
              )),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: currentGameState == GameState.RUNNING
                    ? Colors.white
                    : currentGameState == GameState.DRAW
                        ? Colors.green[100]
                        : currentGameState == GameState.X_WIN
                            ? Colors.red[100]
                            : Colors.blue[100],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentGameState == GameState.RUNNING
                          ? '$_player\'s turn'
                          : currentGameState == GameState.DRAW
                              ? '${currentGameState.toString().split('.').last} \u{1F3F4}'
                              : '\u{1F38A} ${currentGameState.toString().split('.').last} \u{1F38A}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(boardCnt, (index) {
                  return Container(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        color: _boardColors[''],
                        disabledColor: _boardColors[boardStates[index]],
                        child: Text(
                          boardStates[index],
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        onPressed: currentGameState == GameState.RUNNING &&
                                boardStates[index] == ''
                            ? () => _setBoardState(index)
                            : null,
                      ));
                }),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  height: 50,
                  onPressed: _clear,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.teal,
                      ),
                      Text(
                        ' Reset',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
