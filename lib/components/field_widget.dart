import 'package:Minesweeper_Game_Flutter/models/field.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMarked;

  FieldWidget({
    @required this.field,
    @required this.onOpen,
    @required this.onToggleMarked,
  });
  
  Widget _getImage() {
    int numberOfMines = field.numberOfMines;

    if (field.open && field.hasMine && field.explosionField) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.open && field.hasMine) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.open) {
      return Image.asset('assets/images/open_$numberOfMines.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/close.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleMarked(field),
      child: _getImage(),
    );
  }
}