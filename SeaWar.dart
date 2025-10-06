import 'dart:io';
import 'dart:math';

enum CellState { empty, ship, hit, miss }

class Cell {
  CellState state = CellState.empty;
}

class Board {
  List<List<Cell>> grid = List.generate(3, (_) => List.generate(3, (_) => Cell()));

  bool tryPlaceShip(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3) return false;
    var cell = grid[row][col];
    if (cell.state != CellState.empty) return false;
    cell.state = CellState.ship;
    return true;
  }

  (bool success, bool hit) tryAttack(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3) return (false, false);
    var cell = grid[row][col];
    if (cell.state == CellState.hit || cell.state == CellState.miss) return (false, false);
    if (cell.state == CellState.ship) {
      cell.state = CellState.hit;
      return (true, true);
    } else {
      cell.state = CellState.miss;
      return (true, false);
    }
  }

  bool allShipsSunk() {
    for (var row in grid) {
      for (var cell in row) {
        if (cell.state == CellState.ship) return false;
      }
    }
    return true;
  }

  int getRemainingShips() {
    int count = 0;
    for (var row in grid) {
      for (var cell in row) {
        if (cell.state == CellState.ship) count++;
      }
    }
    return count;
  }

  String toString({bool showShips = true}) {
    String getDisplay(CellState state, bool showShips) {
      switch (state) {
        case CellState.hit:
          return 'X';
        case CellState.miss:
          return 'O';
        case CellState.ship:
          return showShips ? 'S' : '.';
        case CellState.empty:
          return '.';
      }
    }

    StringBuffer sb = StringBuffer();
    sb.writeln('  A B C');
    for (int r = 0; r < 3; r++) {
      sb.write('${r + 1} ');
      for (int c = 0; c < 3; c++) {
        String char = getDisplay(grid[r][c].state, showShips);
        sb.write('$char ');
      }
      sb.writeln();
    }
    return sb.toString();
  }
}

(int, int)? parsePosition(String s) {
  if (s.length != 2) return null;
  String letter = s[0].toUpperCase();
  int? col = 'ABC'.indexOf(letter);
  if (col == -1) return null;
  int? rowNum = int.tryParse(s[1]);
  if (rowNum == null || rowNum < 1 || rowNum > 3) return null;
  return (rowNum - 1, col);
}

abstract class Player {
  final String name;
  final Board board;

  Player(this.name) : board = Board();

  void placeShips();
  (int, int) getAttack(Board target);
}

class HumanPlayer extends Player {
  HumanPlayer(String name) : super(name);

  @override
  void placeShips() {
    print('$name, разместите 3 корабля. Вводите позиции вроде A1 (A-C, 1-3), без пересечений.');
    int placed = 0;
    while (placed < 3) {
      stdout.write('Корабль ${placed + 1}: ');
      String? posStr = stdin.readLineSync();
      var pos = parsePosition(posStr ?? '');
      if (pos == null) {
        print('Неверная позиция. Попробуйте снова.');
        continue;
      }
      if (!board.tryPlaceShip(pos.$1, pos.$2)) {
        print('Позиция занята или неверная. Попробуйте снова.');
        continue;
      }
      placed++;
      print('Корабль размещён на $posStr');
    }
  }

  @override
  (int, int) getAttack(Board target) {
    while (true) {
      stdout.write('$name, введите позицию атаки (A1-C3): ');
      String? posStr = stdin.readLineSync();
      var pos = parsePosition(posStr ?? '');
      if (pos == null) {
        print('Неверная позиция. Попробуйте снова.');
        continue;
      }
      return pos;
    }
  }
}

class AIPlayer extends Player {
  AIPlayer(String name) : super(name);

  @override
  void placeShips() {
    Random rand = Random();
    int placed = 0;
    while (placed < 3) {
      int r = rand.nextInt(3);
      int c = rand.nextInt(3);
      if (board.tryPlaceShip(r, c)) {
        placed++;
      }
    }
    print('$name разместил корабли случайно.');
  }

  @override
  (int, int) getAttack(Board target) {
    List<(int, int)> available = [];
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        var cell = target.grid[r][c];
        if (cell.state != CellState.hit && cell.state != CellState.miss) {
          available.add((r, c));
        }
      }
    }
    if (available.isEmpty) {
      throw Exception('Нет доступных атак');
    }
    Random rand = Random();
    return available[rand.nextInt(available.length)];
  }
}

class SeaBattle {
  final Player player1;
  final Player player2;
  bool player1Turn = true;

  SeaBattle(this.player1, this.player2);

  void play() {
    player1.placeShips();
    player2.placeShips();

    print('\nИгра началась! Игрок 1 ходит первым.\n');

    while (!player1.board.allShipsSunk() && !player2.board.allShipsSunk()) {
      Player current = player1Turn ? player1 : player2;
      Board target = player1Turn ? player2.board : player1.board;

      print('\nХод ${current.name}.');
      if (current is HumanPlayer) {
        print('Ваше поле:\n${current.board.toString(showShips: true)}');
        print('Поле противника:\n${target.toString(showShips: false)}');
      }

      bool validAttack = false;
      (int, int)? attackPos;
      while (!validAttack) {
        attackPos = current.getAttack(target);
        var result = target.tryAttack(attackPos.$1, attackPos.$2);
        if (!result.$1) {
          if (current is HumanPlayer) {
            print('Эта клетка уже атакована. Попробуйте другую.');
          } else {
            print('Ошибка ИИ: повторная атака.');
            continue;
          }
        } else {
          validAttack = true;
          if (result.$2) {
            print('${current.name} попал! (X)');
            if (target.allShipsSunk()) {
              print('\n${current.name} победил! Все корабли противника потоплены.');
              print('Финальное поле противника:\n${target.toString(showShips: true)}');
              return;
            }
          } else {
            print('${current.name} промахнулся! (O)');
          }
        }
      }

      if (current is AIPlayer) {
        String posStr = String.fromCharCode(65 + attackPos!.$2) + '${attackPos!.$1 + 1}';
        print('ИИ атакует $posStr.');
      }

      player1Turn = !player1Turn;
    }

    if (!player1.board.allShipsSunk()) {
      print('\n${player2.name} победил!');
    } else if (!player2.board.allShipsSunk()) {
      print('\n${player1.name} победил!');
    }
  }
}

void main() {
  print('Морской бой');
  print('У каждого по 3 одноклеточным кораблям.');
  print('Режимы: 1 - vs ИИ (случайные атаки и размещение), 2 - vs Игрок');
  stdout.write('Выберите режим (1 или 2): ');
  String? input = stdin.readLineSync();

  Player p1 = HumanPlayer('Игрок 1');
  Player p2;
  if (input == '1') {
    p2 = AIPlayer('ИИ');
  } else if (input == '2') {
    p2 = HumanPlayer('Игрок 2');
  } else {
    print('Неверный выбор. Запустите заново.');
    return;
  }

  SeaBattle game = SeaBattle(p1, p2);
  game.play();
}