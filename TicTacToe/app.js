var game = require('./game.js');
var playerX = {};
var playerO = {};
function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
  }
playerX.move = function(board) {
    while (true) {
        var row = getRandomInt(board.size);
        var col = getRandomInt(board.size);
        var value = board.valueAt(row, col);
        if (value == null) {
            return board.move(row, col);
        }
    }
}
playerO.move = function(board) {
    while (true) {
        var row = getRandomInt(board.size);
        var col = getRandomInt(board.size);
        var value = board.valueAt(row, col);
        if (value == null) {
            return board.move(row, col);
        }
    }
}
for (let count = 0; count < 100; count++) {
    var firstGame = game.game(3);
    var result = firstGame.play(playerX, playerO);
    console.log(result);
    var b = firstGame.print();
    console.log(b);
}

