function MyMath() {

  function add(a, b) {
    return a + b;
  }

  function subtract(a, b) {
    return a - b;
  }

  function multiply(a, b) {
    return a * b;
  }

  function power(a, b) {
    return Math.pow(a, b);
  }

  function factorial(a) {
    if (a === 0 || a === 1)
      return 1;
    else {
      return (a * factorial(a - 1));
    }
  }

  function fibonacci(a) {
    if (a === 0) {
      return 0;
    } if (a === 1) {
      return 1;
    } else {
      return (fibonacci(a - 1) + fibonacci(a - 2));
    }
  }

  function isEven(a) {
    if (a % 2 === 0) {
      return true;
    } else {
      return false;
    }
  }

  function isOdd(a) {
    if (a % 2 !== 0) {
      return true;
    } else {
      return false;
    }
  }

  function divisors(a) {
    list = [];
    for (var i = 1; i <= a; i++) {
      if (a % i === 0) {
        list.push(i);
      }
    }
    return list;
  }

  function isPrime(a) {
    for (var i = 1; i <= a; i++) {
      if (divisors(a).length === 2) {
        return true;
      } else {
        return false;
      }
    }
  }

  function primesUpTo(a) {
    primeList = [];
    if (isPrime(a).length === 2) {
      primeList.push(a);
    }
    return primeList;
  }

  return {
    add,
    subtract,
    multiply,
    power,
    factorial,
    fibonacci,
    isEven,
    isOdd,
    divisors,
    isPrime,
    primesUpTo
  }

}

module.exports = MyMath();