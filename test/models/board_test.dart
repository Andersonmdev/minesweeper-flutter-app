import 'package:Minesweeper_Game_Flutter/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Should wind the game', () {
    Board board = Board(
      rows: 2,
      columns: 2,
      numberMines: 0,
    );

    board.fields[0].putMine();
    board.fields[3].putMine();

    board.fields[0].toggleMarked();
    board.fields[1].openField();
    board.fields[2].openField();
    board.fields[3].toggleMarked();

    expect(board.resolved, isTrue);
  });
}