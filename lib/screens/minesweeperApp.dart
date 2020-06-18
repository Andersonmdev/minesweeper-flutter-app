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
  bool _win;
  Board _board = Board (
    rows: 12,
    columns: 12,
    numberMines: 4,
  );
  
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
        appBar: ResultWidget(
          win: _win,
          onRestart: _restart,
        ),
        body: Container(
          child: Container(
            padding: EdgeInsets.all(10),
            child: BoardWidget(
              board: _board,
              onOpen: _open,
              onToggleMarked: _toggleMarked,
            ),
          ),
        ),
      ),
    );
  }
}