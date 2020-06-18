import 'package:Minesweeper_Game_Flutter/models/field.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Field Test', () {

    test('Should open field with explosion', () {
      Field f = Field(row: 0, column: 0);
      f.putMine();

      expect(f.openField, throwsException);
    }); 

    test('Should open field without explosion', () {
      Field f = Field(row: 0, column: 0);
      f.openField();

      expect(f.open, isTrue);
    }); 

    test('Should add next field', () {
      Field f1 = Field(row: 0, column: 0);
      Field f2 = Field(row: 1, column: 1);
      f1.addNextField(f2);

      expect(f1.next.length, 1);
    });

    test('Should not add next field', () {
      Field f1 = Field(row: 0, column: 0);
      Field f2 = Field(row: 1, column: 3);
      f1.addNextField(f2);

      expect(f1.next.isEmpty, isTrue);
    });

    test('Should be one mine nearby', () {
      Field f1 = Field(row: 1, column: 1);
      Field f2 = Field(row: 1, column: 2);
      f2.putMine();
      Field f3 = Field(row: 2, column: 2);
      f1.addNextField(f2);
      f1.addNextField(f3);

      expect(f1.numberOfMines, 1);
    });
  });
}