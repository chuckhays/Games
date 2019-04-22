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

  return {
    add,
    subtract,
    multiply,
    power,
    factorial,
  }

}

module.exports = MyMath();