var assert = require('assert');
var math = require('../math');

describe('MyMath', function () {
    describe('add', function () {
        it('should add normal numbers', function () {
            var sum = math.add(1, 2);
            assert.equal(sum, 3);
        });
        it('should add negative numbers', function () {
            var sum = math.add(-4, -9);
            assert.equal(sum, -13);
        });
        it('should add mixed numbers', function () {
            var sum = math.add(10, -12);
            assert.equal(sum, -2);
        });
        it('should add equal numbers', function () {
            var sum = math.add(2, -2);
            assert.equal(sum, 0);
        });
    });
    describe('subtract', function () {
        it('should subtract normal numbers', function () {
            var sum = math.subtract(1, 2);
            assert.equal(sum, -1);
        });
        it('should subtract negative numbers', function () {
            var sum = math.subtract(-4, -9);
            assert.equal(sum, 5);
        });
        it('should subtract mixed numbers', function () {
            var sum = math.subtract(10, -12);
            assert.equal(sum, 22);
        });
        it('should subtract equal numbers', function () {
            var sum = math.subtract(2, -2);
            assert.equal(sum, 4);
        });
    });
});