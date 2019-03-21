'use strict';

exports.game = function (boardSize) {
  var game = {};
  var board = [];

  var X = 'X';
  var O = 'O';
  var draw = 'D';
  game.X = X;
  game.O = O;
  game.draw = draw;

  var indexFor = function (row, col) {
    return row * boardSize + col;
  }

  var valueAt = function (row, col) {
    return board[indexFor(row, col)];
  }

  var setValueAt = function (row, col, value) {
    board[indexFor(row, col)] = value;
  }

  var winner = function () {
    var diagonalX1 = 0, diagonalO1 = 0, diagonalX2 = 0, diagonalO2 = 0;
    var isDraw = true;
    for (let i = 0; i < boardSize; i++) {
      var horizontalX = 0, horizontalO = 0, verticalX = 0, verticalO = 0;
      for (let j = 0; j < boardSize; j++) {
        if (valueAt(i, j) == null) {
          isDraw = false;
        }
        var horizontalValue = valueAt(i, j);
        if (horizontalValue === X) {
          horizontalX++;
        } else if (horizontalValue === O) {
          horizontalO++;
        }
        var verticalValue = valueAt(j, i);
        if (verticalValue === X) {
          verticalX++;
        } else if (verticalValue === O) {
          verticalO++;
        }
      }
      if (horizontalX == boardSize || verticalX == boardSize) {
        return X;
      } else if (horizontalO == boardSize || verticalO == boardSize) {
        return O;
      }
      // Check diags here.
      var diagonal1Value = valueAt(i, i);
      if (diagonal1Value === X) {
        diagonalX1++;
      } else if (diagonal1Value === O) {
        diagonalO1++;
      }
      var diagonal2Value = valueAt(i, boardSize - 1 - i);
      if (diagonal2Value === X) {
        diagonalX2++;
      } else if (diagonal2Value === O) {
        diagonalO2++;
      }
    }
    if (diagonalX1 == boardSize || diagonalX2 == boardSize) {
      return X;
    } else if (diagonalO1 == boardSize || diagonalO2 == boardSize) {
      return O;
    }
    if (isDraw) {
      return draw;
    }
    return null;
  }

  game.print = function () {
    var output = '';
    for (let row = 0; row < boardSize; row++) {
      for (let col = 0; col < boardSize; col++) {
        var value = valueAt(row, col);
        if (value == null) {
          output += ' ';
        } else {
          output += value;
        }
      }
      output += '\r\n';
    }
    return output;
  }

  game.play = function (playerX, playerO) {
    // Init board.
    board = [boardSize * boardSize];
    for (let i = 0; i < boardSize; i++) {
      board[i] = null;
    }

    var xTurn = true;

    while (winner() == null) {
      var move = null;
      var gameBoard = {};
      gameBoard.valueAt = function (row, col) {
        return board[indexFor(row, col)];
      }
      gameBoard.size = boardSize;
      gameBoard.move = function (row, col) {
        var move = {};
        move.row = row;
        move.col = col;
        return move;
      }
      if (xTurn) {
        move = playerX.move(gameBoard);
      } else {
        move = playerO.move(gameBoard);
      }
      // Check if move is legal.
      var currentValue = valueAt(move.row, move.col);
      if (currentValue != null) {
        return xTurn ? O : X;
      }
      if (move.row >= boardSize || move.row < 0 || move.col >= boardSize || move.col < 0) {
        return xTurn ? O : X;
      }
      // Perform move.
      setValueAt(move.row, move.col, xTurn ? X : O);
      xTurn = !xTurn;
    }
    return winner();
  }

  return game;
}
exports.gameSeries = function (boardSize, numGames, player1, player2) {
  var series = {};

  series.play = function (print) {
    var player1Wins = 0;
    var player2Wins = 0;
    var draws = 0;

    for (let count = 0; count < numGames; count++) {
      var game = exports.game(boardSize);
      var player1IsX = (count % 2 == 0);
      var playerX = player1IsX ? player1 : player2;
      var playerO = player1IsX ? player2 : player1;
      var result = game.play(playerX, playerO);
      if (result === game.draw) {
        draws++;
      } else if (result === game.X) {
        if (player1IsX) {
          player1Wins++;
        } else {
          player2Wins++;
        }
      } else {
        if (player1IsX) {
          player2Wins++;
        } else {
          player1Wins++;
        }
      }
      if (print) {
        console.log("Result: " + result);
        var board = game.print();
        console.log(board);
      }
    }

    return {
      player1Wins: player1Wins,
      player2Wins: player2Wins,
      draws: draws,
    };
  }

  return series;
}