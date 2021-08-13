library currency;

import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  /// Value of currency in centesimal units (1/100 of the basic monetary unit)
  final int _value;

  /// Constructs a new Currency object by value, where value is an [int]
  /// representing the monetary value in centesimal units (1/100 of the
  /// basic monetary unit)
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
  Currency operator /(double mod) {
    if (mod == 0) {
      throw UnsupportedError("Division of a currency by 0 is not supported.");
    }
    return Currency.fromDouble(this.value / mod);
  }

  bool operator <(Currency other) => (this._value < other._value);
  bool operator >(Currency other) => (this._value > other._value);
  bool operator <=(Currency other) => (this._value <= other._value);
  bool operator >=(Currency other) => (this._value >= other._value);

  Currency operator -() => Currency(-this._value);

  @override
  String toString({String symbol: '\$'}) {
    return (_value < 0 ? '-' : '') + symbol + value.abs().toStringAsFixed(2);
  }

  @override
  List<Object?> get props => [_value];
}
