import 'dart:math';
import 'package:flutter/foundation.dart';
import 'field.dart';

class Board {
  final int rows;
  final int columns;
  final int numberMines;

  final List<Field> _fields = [];

  Board({
    @required this.rows,
    @required this.columns,
    @required this.numberMines,
  }) {
    _createFields();
    _relateNext();
    _shuffleMines();
  }

  void restart() {
    _fields.forEach((element) => element.restart());
    _shuffleMines();
  }

  void revealMines() {
    _fields.forEach((element) => element.revealMine());
  }

  void _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(row: r, column: c));
      }
    }
  }

  void _relateNext() {
    for(var f in _fields) {
      for(var n in _fields) {
        f.addNextField(n);
      }
    }
  }

  void _shuffleMines() {
    int shuffle = 0;

    if (numberMines > rows * columns) {
      return;
    }

    while(shuffle < numberMines) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].hasMine) {
        shuffle++;
        _fields[i].putMine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((element) => element.resolved);
  }
}
