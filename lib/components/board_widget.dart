import 'package:Minesweeper_Game_Flutter/components/field_widget.dart';
import 'package:Minesweeper_Game_Flutter/models/board.dart';
import 'package:Minesweeper_Game_Flutter/models/field.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMarked;

  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onToggleMarked,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((f) {
          return FieldWidget(
            field: f,
            onOpen: onOpen,
            onToggleMarked: onToggleMarked,
          );
        }).toList(),
      ),
    );
  }
}