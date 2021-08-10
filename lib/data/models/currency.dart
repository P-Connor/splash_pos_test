import 'package:flutter/foundation.dart';

@immutable
class Currency {
  final int _value;

  /// Constructs a new Currency object by value, where value is an [int]
  /// representing the monetary value * 100
  const Currency(int value) : _value = value;

  /// Constructs a new Currency object by value, where value is a [double]
  /// representing the exact monetary value
  Currency.fromDouble(double impreciseValue)
      : _value = (impreciseValue * 100.0).round();

  /// Returns the exact monetary value of this [Currency] object as a [double]
  double get value => _value.toDouble() * 0.01;

  Currency operator +(Currency other) => Currency(this._value + other._value);
  Currency operator -(Currency other) => Currency(this._value - other._value);

  Currency operator *(double mod) => Currency.fromDouble(this.value * mod);
  Currency operator /(double mod) => Currency.fromDouble(this.value / mod);

  bool operator <(Currency other) => (this._value < other._value);
  bool operator >(Currency other) => (this._value > other._value);
  bool operator <=(Currency other) => (this._value <= other._value);
  bool operator >=(Currency other) => (this._value >= other._value);

  Currency operator -() => Currency(-this._value);

  @override
  bool operator ==(Object other) =>
      (other is Currency) && (other._value == this._value);

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() {
    return "\$" + value.toStringAsFixed(2);
  }
}
