var game = require('./game.js');
var players = require('./players.js');

console.log('2 random players');
var player1 = players.randomPlayer();
var player2 = players.randomPlayer();
var series = game.gameSeries(3, 100000, player1, player2);
var result = series.play(false);
console.log(result);
console.log('1 random player, 1 blocking player');
player2 = players.randomBlockingPlayer();
series = game.gameSeries(3, 100000, player1, player2);
result = series.play(false);
console.log(result);

