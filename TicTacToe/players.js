'use strict';

exports.andiPlayer = function () {
  var player = {};
  player.move = function (board, ourMark) {
    // Return a valid move here.
    // ourMark will be X or O, but it doesn't matter, you can compare it to 
    // what is in each spot.
    // An empty spot will have value null, one that is yours will have ourMark,
    // otherwise it belongs to the other player.
    // You can use board.valueAt(r, c) to see what is in each spot.
    // row and col are 0 indexed.
    // board.size contains the size of the board, board is square.
    // Return your move by creating it with board.move(r, c);
  }
  return player;
}

exports.randomPlayer = function () {
  var player = {};
  function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
  }
  player.move = function (board, ourMark) {
    while (true) {
      var row = getRandomInt(board.size);
      var col = getRandomInt(board.size);
      var value = board.valueAt(row, col);
      if (value == null) {
        return board.move(row, col);
      }
    }
  }

  return player;
}

exports.randomBlockingPlayer = function () {
  var player = {};
  function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
  }
  player.move = function (board, ourMark) {
    // First check if we can block anything.
    var size = board.size;
    var diagonalUs1 = 0, diagonalThem1 = 0, diagonalUs2 = 0, diagonalThem2 = 0;
    for (let i = 0; i < size; i++) {
      var hUsCount = 0;
      var vUsCount = 0;
      var hThemCount = 0;
      var vThemCount = 0;
      for (let j = 0; j < size; j++) {
        var hValue = board.valueAt(j, i);
        var vValue = board.valueAt(i, j);
        if (hValue === ourMark) {
          hUsCount++;
        } else if (hValue != null) {
          hThemCount++;
        }
        if (vValue === ourMark) {
          vUsCount++;
        } else if (hValue != null) {
          vThemCount++;
        }
      }
      // Check if they have size -1 in a row or col and we have none.
      if (hThemCount == size - 1 && hUsCount == 0) {
        for (let j = 0; j < size; j++) {
          var value = board.valueAt(i, j);
          if (value == null) {
            return board.move(i, j);
          }
        }
      } else if (vThemCount == size - 1 && vUsCount == 0) {
        for (let j = 0; j < size; j++) {
          var value = board.valueAt(j, i);
          if (value == null) {
            return board.move(j, i);
          }
        }
      }
      // Check diags.
      var diag1Value = board.valueAt(i, i);
      if (diag1Value === ourMark) {
        diagonalUs1++;
      } else if (diag1Value != null) {
        diagonalThem1++;
      }
      var diag2Value = board.valueAt(i, size - 1 - i);
      if (diag2Value === ourMark) {
        diagonalUs2++;
      } else if (diag2Value != null) {
        diagonalThem2++;
      }
    }
    if (diagonalThem1 == size - 1 && diagonalUs1 == 0) {
      for (let i = 0; i < size; i++) {
        var value = board.valueAt(i, i);
        if (value == null) {
          return board.move(i, i);
        }
      }
    } else if (diagonalThem2 == size - 1 && diagonalUs2 == 0) {
      for (let i = 0; i < size; i++) {
        var value = board.valueAt(i, size - 1 - i);
        if (value == null) {
          return board.move(i, size - 1 - i);
        }
      }
    }

    while (true) {
      var row = getRandomInt(board.size);
      var col = getRandomInt(board.size);
      var value = board.valueAt(row, col);
      if (value == null) {
        return board.move(row, col);
      }
    }
  }

  return player;
}