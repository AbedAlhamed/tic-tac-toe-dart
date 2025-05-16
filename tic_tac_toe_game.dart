// Simple Tic-Tac-Toe game
//To be honest, I already had the idea of the game,
//but I relied on external sources to figure out the necessary
// libraries for the implementation.

import 'dart:io'; // Library for console input/output

/// Entry point of the program
void main() {
  while (true) {
    playGame(); // Start a new game
    stdout.write('Do you want to play again? (y/n): ');
    if (stdin.readLineSync()?.toLowerCase() != 'y')
      break; // Exit if not 'y' => yes
  }
}

/// Function to run a single game
void playGame() {
  // Create the board with numbers from 1 to 9
  List<String> board = List.generate(9, (i) => '${i + 1}');
  String currentPlayer = 'X'; // Player X starts first

  // Main game loop: max 9 turns
  for (int turn = 0; turn < 9; turn++) {
    showBoard(board); // Display the current board
    int move = getPlayerMove(
      board,
      currentPlayer,
    ); // Get the move from the player
    board[move] = currentPlayer; // Apply the move to the board

    if (checkWin(board, currentPlayer)) {
      showBoard(board); // Show the final board
      print('Player $currentPlayer wins!');
      return; // End the game if there's a winner
    }

    // Switch turns between X and O
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  // If no winner after 9 turns, it's a draw
  showBoard(board);
  print("It's a draw!");
}

/// Function to display the board in 3x3 format
void showBoard(List<String> board) {
  for (int i = 0; i < 9; i += 3) {
    print('[${board[i]}][${board[i + 1]}][${board[i + 2]}]');
  }
}

/// Function to get and validate the player's move
int getPlayerMove(List<String> board, String currentPlayer) {
  while (true) {
    stdout.write('Player $currentPlayer, choose (1-9): ');
    var input = int.tryParse(stdin.readLineSync() ?? '');

    // Check that the input is in range and the cell is empty
    if (input != null &&
        input >= 1 &&
        input <= 9 &&
        board[input - 1] != 'X' &&
        board[input - 1] != 'O') {
      return input - 1; // Convert to list index
    } else {
      print('Invalid move.'); // Ask again if the input is invalid
    }
  }
}

/// Function to check if the current player has won
bool checkWin(List<String> board, String currentPlayer) {
  // All possible winning patterns (rows, columns, diagonals)
  List<List<int>> winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
    [0, 4, 8], [2, 4, 6], // diagonals
  ];

  // Check if any winning pattern is fully occupied by the same player
  return winPatterns.any(
    (pattern) =>
        board[pattern[0]] == currentPlayer &&
        board[pattern[1]] == currentPlayer &&
        board[pattern[2]] == currentPlayer,
  );
}
