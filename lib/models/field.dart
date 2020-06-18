import 'package:flutter/foundation.dart';
import 'explosionException.dart';

class Field {
  final int row;
  final int column;
  final List<Field> next = []; // Neighboring fields

  bool _open = false; // Field is open?
  bool _marked = false; // Field is marked?
  bool _hasMine = false; // Field has a mine?
  bool _explosionField = false; // Field start explosion?

  Field({
    @required this.row,
    @required this.column,
  });

  void addNextField(Field nextField) {
    final deltaRow = (row - nextField.row).abs();
    final deltaColumn = (column - nextField.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      next.add(nextField);
    }
  }

  void openField() {
    if (_open) {
      return;
    }

    _open = true;

    if (_hasMine) {
      _explosionField = true;
      throw ExplosionException();
    }

    if (nextIsSafe) {
      next.forEach((element) => element.openField());
    }
  }

  void revealMine() {
    if (_hasMine) {
      _open = true;
    }
  }

  void putMine() {
    _hasMine = true;
  }

  void toggleMarked() {
    _marked = !_marked;
  }

  void restart() {
    _open = false;
    _marked = false;
    _hasMine = false;
    _explosionField = false;
  }

  bool get open {
    return _open;
  }

  bool get marked {
    return _marked;
  }

  bool get hasMine {
    return _hasMine;
  }

  bool get explosionField {
    return _explosionField;
  }

  bool get resolved {
    bool hasMineAndMarked = _hasMine && _marked;
    bool safeAndOpen = !_hasMine && _open;
    bool safeAndNotOpen = !_hasMine && !_open;
    return hasMineAndMarked || safeAndOpen || safeAndNotOpen;
  }

  bool get nextIsSafe {
    return next.every((element) => !element._hasMine);
  }

  int get numberOfMines {
    return next.where((element) => element._hasMine).length;
  }
}
