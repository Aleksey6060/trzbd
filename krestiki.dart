import 'dart:io';
import 'dart:math';

void main() {
  print('Welcome to Tic-Tac-Toe!');
  while (true) {
    playGame();
    print('Would you like to play again? (yes/no)');
    String? playAgain = stdin.readLineSync()?.toLowerCase();
    if (playAgain != 'yes') {
      print('Thanks for playing!');
      break;
    }
  }
}

class TicTacToe {
  late List<List<String>> board;
  late int size;
  String currentPlayer = 'X';
  bool isComputerMode = false;

  void initializeGame() {
    print('Enter the size of the board (e.g., 3 for 3x3):');
    size = int.parse(stdin.readLineSync()!);
    board = List.generate(size, (_) => List.filled(size, ' '));
    print('Choose game mode: 1) Player vs Player, 2) Player vs Computer');
    String? mode = stdin.readLineSync();
    isComputerMode = mode == '2';
    currentPlayer = Random().nextBool() ? 'X' : 'O';
    print('Starting player: $currentPlayer');
  }

  void printBoard() {
    for (int i = 0; i < size; i++) {
      print(board[i].join(' | '));
      if (i < size - 1) print('-' * (size * 4 - 1));
    }
    print('');
  }

  bool makeMove(int row, int col) {
    if (row >= 0 &&
        row < size &&
        col >= 0 &&
        col < size &&
        board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      return true;
    }
    return false;
  }

  bool checkWin() {
    for (int i = 0; i < size; i++) {
      if (board[i].every((cell) => cell == currentPlayer)) return true;
    }
    for (int j = 0; j < size; j++) {
      bool win = true;
      for (int i = 0; i < size; i++) {
        if (board[i][j] != currentPlayer) {
          win = false;
          break;
        }
      }
      if (win) return true;
    }
    bool win = true;
    for (int i = 0; i < size; i++) {
      if (board[i][i] != currentPlayer) {
        win = false;
        break;
      }
    }
    if (win) return true;
    win = true;
    for (int i = 0; i < size; i++) {
      if (board[i][size - 1 - i] != currentPlayer) {
        win = false;
        break;
      }
    }
    return win;
  }

  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }

  void computerMove() {
    Random rand = Random();
    int row, col;
    do {
      row = rand.nextInt(size);
      col = rand.nextInt(size);
    } while (!makeMove(row, col));
    print('Computer moves to (${row + 1}, ${col + 1})');
  }

  void switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

void playGame() {
  var game = TicTacToe();
  game.initializeGame();

  while (true) {
    game.printBoard();
    if (game.isComputerMode && game.currentPlayer == 'O') {
      game.computerMove();
    } else {
      print(
        'Player ${game.currentPlayer}, enter your move (row col, e.g., 1 1 for top-left):',
      );
      var input = stdin.readLineSync()!.split(' ');
      int row = int.parse(input[0]) - 1;
      int col = int.parse(input[1]) - 1;
      if (row < 0 ||
          row >= game.size ||
          col < 0 ||
          col >= game.size ||
          !game.makeMove(row, col)) {
        print('Invalid move, try again. Use numbers from 1 to ${game.size}.');
        continue;
      }
    }

    if (game.checkWin()) {
      game.printBoard();
      print('Player ${game.currentPlayer} wins!');
      break;
    }
    if (game.isBoardFull()) {
      game.printBoard();
      print('It\'s a draw!');
      break;
    }
    game.switchPlayer();
  }
}
