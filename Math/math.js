function MyMath() {

  function add(a, b) {
    return a + b;
  }

  function subtract(a, b) {
    return a - b;
  }

  function multiply(a, b) {
    return 0;
  }

  function power(a, b) {
    return 0;
  }

  function factorial(a) {
    return 0;
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