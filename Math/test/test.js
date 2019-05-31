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
    describe('multiply', function () {
        it('should multiply normal numbers', function () {
            var sum = math.multiply(1, 2);
            assert.equal(sum, 2);
        });
        it('should multiply negative numbers', function () {
            var sum = math.multiply(-4, -9);
            assert.equal(sum, 36);
        });
        it('should multiply mixed numbers', function () {
            var sum = math.multiply(10, -12);
            assert.equal(sum, -120);
        });
        it('should multiply equal numbers', function () {
            var sum = math.multiply(2, -2);
            assert.equal(sum, -4);
        });
    });
    describe('power', function () {
        it('should power normal numbers', function () {
            var sum = math.power(1, 2);
            assert.equal(sum, 1);
        });
        it('should power negative numbers', function () {
            var sum = math.power(-4, 3);
            assert.equal(sum, -64);
        });
        it('should power numbers', function () {
            var sum = math.power(10, 4);
            assert.equal(sum, 10000);
        });
        it('should power to 0th', function () {
            var sum = math.power(2, 0);
            assert.equal(sum, 1);
        });
    });
    describe('factorial', function () {
        it('should factorial normal numbers', function () {
            var sum = math.factorial(5);
            assert.equal(sum, 120);
        });
        it('should factorial 0', function () {
            var sum = math.factorial(0);
            assert.equal(sum, 1);
        });
        it('should factorial 1', function () {
            var sum = math.factorial(0);
            assert.equal(sum, 1);
        });
        it('should factorial 2', function () {
            var sum = math.factorial(0);
            assert.equal(sum, 1);
        });
    });
    describe('fibonacci', function () {
        it('should find fibonacci of 5', function () {
            var sum = math.fibonacci(5);
            assert.equal(sum, 5);
        });
        it('should find fibonacci of 0', function () {
            var sum = math.fibonacci(0);
            assert.equal(sum, 0);
        });
        it('should find fibonacci of 1', function () {
            var sum = math.fibonacci(1);
            assert.equal(sum, 1);
        });
        it('should find fibonacci of 10', function () {
            var sum = math.fibonacci(10);
            assert.equal(sum, 55);
        });
    });
    describe('isEven', function () {
        it('should determine if 0 is even', function () {
            var sum = math.isEven(0);
            assert.equal(sum, true);
        });
        it('should determine if 1 is even', function () {
            var sum = math.isEven(1);
            assert.equal(sum, false);
        });
        it('should determine if 2 is even', function () {
            var sum = math.isEven(2);
            assert.equal(sum, true);
        });
        it('should determine if 100 is even', function () {
            var sum = math.isEven(100);
            assert.equal(sum, true);
        });
        it('should determine if 101 is even', function () {
            var sum = math.isEven(101);
            assert.equal(sum, false);
        });
    });
    describe('isOdd', function () {
        it('should determine if 0 is odd', function () {
            var sum = math.isOdd(0);
            assert.equal(sum, false);
        });
        it('should determine if 1 is odd', function () {
            var sum = math.isOdd(1);
            assert.equal(sum, true);
        });
        it('should determine if 100 is odd', function () {
            var sum = math.isOdd(100);
            assert.equal(sum, false);
        });
        it('should determine if 101 is odd', function () {
            var sum = math.isOdd(101);
            assert.equal(sum, true);
        });
        it('should determine if 777 is odd', function () {
            var sum = math.isOdd(777);
            assert.equal(sum, true);
        });
    });
    describe('divisors', function () {
        it('should find divisors of 5', function () {
            var sum = math.divisors(5);
            assert.deepStrictEqual(sum, [1, 5]);
        });
        it('should find divisors of 100', function () {
            var sum = math.divisors(100);
            assert.deepStrictEqual(sum, [1, 2, 4, 5, 10, 20, 25, 50, 100]);
        });
        it('should find divisors of 20', function () {
            var sum = math.divisors(20);
            assert.deepStrictEqual(sum, [1, 2, 4, 5, 10, 20]);
        });
        it('should find divisors of 74', function () {
            var sum = math.divisors(74);
            assert.deepStrictEqual(sum, [1, 2, 37, 74]);
        });
        it('should find divisors of 31', function () {
            var sum = math.divisors(31);
            assert.deepStrictEqual(sum, [1, 31]);
        });
    });
    describe('isPrime', function () {
        it('should determine if 5 is prime', function () {
            var sum = math.isPrime(5);
            assert.equal(sum, true);
        });
        it('should determine if 100 is prime', function () {
            var sum = math.isPrime(100);
            assert.equal(sum, false);
        });
        it('should determine if 20 is prime', function () {
            var sum = math.isPrime(20);
            assert.equal(sum, false);
        });
        it('should determine if 74 is prime', function () {
            var sum = math.isPrime(74);
            assert.equal(sum, false);
        });
        it('should determine if 31 is prime', function () {
            var sum = math.isPrime(31);
            assert.equal(sum, true);
        });
    });
    describe('primesUpTo', function () {
        it('should find primesUpTo of 5', function () {
            var sum = math.primesUpTo(5);
            assert.deepStrictEqual(sum, [2, 3, 5]);
        });
        it('should find primesUpTo of 100', function () {
            var sum = math.primesUpTo(100);
            assert.deepStrictEqual(sum, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]);
        });
        it('should find primesUpTo of 20', function () {
            var sum = math.primesUpTo(20);
            assert.deepStrictEqual(sum, [2, 3, 5, 7, 11, 13, 17, 19]);
        });
        it('should find primesUpTo of 74', function () {
            var sum = math.primesUpTo(74);
            assert.deepStrictEqual(sum, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73]);
        });
        it('should find primesUpTo of 31', function () {
            var sum = math.primesUpTo(31);
            assert.deepStrictEqual(sum, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]);
        });
    });
});