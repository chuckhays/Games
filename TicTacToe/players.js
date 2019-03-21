'use strict';

exports.randomPlayer = function () {
  var player = {};
  function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
  }
  player.move = function (board) {
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