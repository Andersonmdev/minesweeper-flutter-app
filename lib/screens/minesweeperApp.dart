import 'package:flutter/material.dart';
import 'package:Minesweeper_Game_Flutter/models/field.dart';
import 'package:Minesweeper_Game_Flutter/models/board.dart';
import 'package:Minesweeper_Game_Flutter/models/explosionException.dart';
import 'package:Minesweeper_Game_Flutter/components/result_widget.dart';
import 'package:Minesweeper_Game_Flutter/components/board_widget.dart';

class MinesweeperApp extends StatefulWidget {
  
  @override
  _MinesweeperAppState createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  final List<String> choices = ['Size Board', 'Number Mines'];
  List<int> _optionSize = [0, 1, 0, 0];
  List<int> _optionLevel = [0, 1, 0];
  bool _win;
  Board _board = Board (
    rows: 8,
    columns: 8,
    numberMines: 8,
  );

  int _defineBoardSize() {
    if (_optionSize[0] == 1) {
      return 6;
    } 
    if (_optionSize[1] == 1) {
      return 8;
    } 
    if (_optionSize[2] == 1) {
      return 10;
    } 
    return 12;
  }

  int _defineOptionLevel() {
    if (_optionLevel[0] == 1) {
      return 4;
    } 
    if (_optionLevel[1] == 1) {
      return 8;
    } 
    return 12;
  }

  void _restart() {
    setState(() {
      _win = null;
      _board.restart();
    });
  }

  void _open(Field f) {
    setState(() {
      if (_win != null) {
        return;
      }
      try {
        f.openField();
        if (_board.resolved) {
          _win = true;
        }
      } on ExplosionException {
        _win = false;
        _board.revealMines();
      }
    });
  }

  void _toggleMarked(Field f) {
    setState(() {
      if (_win != null) {
        return;
      }
      f.toggleMarked();
      if (_board.resolved) {
        _win = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome Minesweeper App'),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              child: PopupMenuButton<String>(
                itemBuilder: (BuildContext context) { 
                  return [
                    PopupMenuItem<String> (
                      value: choices[0],
                      child: ListTile(
                        title: Text(choices[0]),
                        contentPadding: EdgeInsets.all(0),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Choose the board size'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    RadioListTile(
                                      title: Text('6 x 6'),
                                      groupValue: _optionSize[0],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionSize[0] = n;
                                          _optionSize[1] = 0;
                                          _optionSize[2] = 0;
                                          _optionSize[3] = 0;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text('8 x 8'),
                                      groupValue: _optionSize[1],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionSize[0] = 0;
                                          _optionSize[1] = n;
                                          _optionSize[2] = 0;
                                          _optionSize[3] = 0;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text('10 x 10'),
                                      groupValue: _optionSize[2],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionSize[0] = 0;
                                          _optionSize[1] = 0;
                                          _optionSize[2] = n;
                                          _optionSize[3] = 0;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text('12 x 12'),
                                      groupValue: _optionSize[3],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionSize[0] = 0;
                                          _optionSize[1] = 0;
                                          _optionSize[2] = 0;
                                          _optionSize[3] = n;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text('OK'),
                                    onPressed: () {
                                      setState(() {
                                        int size = _defineBoardSize();
                                        _board = Board (
                                          rows: size,
                                          columns: size,
                                          numberMines: 4,
                                        );
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ),
                    PopupMenuItem<String> (
                      value: choices[1],
                      child: ListTile(
                        title: Text(choices[1]),
                        contentPadding: EdgeInsets.all(0),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Choose the difficulty'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    RadioListTile(
                                      title: Text('Easy'),
                                      groupValue: _optionLevel[0],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionLevel[0] = n;
                                          _optionLevel[1] = 0;
                                          _optionLevel[2] = 0;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text('Normal'),
                                      groupValue: _optionLevel[1],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionLevel[0] = 0;
                                          _optionLevel[1] = n;
                                          _optionLevel[2] = 0;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text('Hard'),
                                      groupValue: _optionLevel[2],
                                      value: 1,
                                      onChanged: (n) {
                                        setState(() {
                                          _optionLevel[0] = 0;
                                          _optionLevel[1] = 0;
                                          _optionLevel[2] = n;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text('OK'),
                                    onPressed: () {
                                      setState(() {
                                        int size = _defineBoardSize();
                                        int level = _defineOptionLevel();
                                        _board = Board (
                                          rows: size,
                                          columns: size,
                                          numberMines: level,
                                        );
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ),
                  ];
                },
              )
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 18),
              child: ResultWidget(
                win: _win,
                onRestart: _restart,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 80, 5, 0),
              child: BoardWidget(
                board: _board,
                onOpen: _open,
                onToggleMarked: _toggleMarked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}