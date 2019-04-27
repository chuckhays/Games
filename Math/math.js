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

  }

  //function primes(a) {}

  return {
    add,
    subtract,
    multiply,
    power,
    factorial,
    fibonacci,
    isEven,
    isOdd,
    divisors
  }

}

module.exports = MyMath();