var game = require('./game.js');
var players = require('./players.js');

var player1 = players.randomPlayer();
var player2 = players.randomPlayer();
var series = game.gameSeries(3, 100000, player1, player2);
var result = series.play(false);
console.log(result);

