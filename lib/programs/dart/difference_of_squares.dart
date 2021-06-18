import 'dart:math';

class DifferenceOfSquares {
  int squareOfSum(int n) {
    return pow(_sumNatural(n), 2).toInt();
  }

  int _sumNatural(int n) => (n * (n + 1)) ~/ 2;

  int sumOfSquares(int n) => (n * (n + 1) * ((2 * n) + 1)) ~/ 6;

  int differenceOfSquares(int n) => squareOfSum(n) - sumOfSquares(n);
}
