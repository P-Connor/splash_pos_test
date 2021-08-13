import 'package:flutter_test/flutter_test.dart';
import 'package:currency/currency.dart';

void main() {
  group('Currency: ', () {
    test('value should start at 0', () {
      expect(Currency(0).value, 0.0);
    });

    test('two currencies with same value are equal', () {
      expect(Currency(0), Currency(0));
      expect(Currency(3431), Currency(3431));
      expect(Currency(-3431), Currency(-3431));
    });

    test('addition yields correct result', () {
      expect(Currency(-145) + Currency(312), Currency(312 - 145));
      expect(Currency(-145) + Currency(-312), Currency(-457));
      expect(Currency(145) + Currency(312), Currency(457));
    });

    test('subtraction yields correct result', () {
      expect(Currency(145) - Currency(312), Currency(145 - 312));
      expect(Currency(-145) - Currency(-312), Currency(-145 + 312));
      expect(Currency(-145) - Currency(312), Currency(-145 - 312));
    });

    test('multiplication yields correct result', () {
      expect((Currency(458) * 1.075).value, 4.92);
      expect((Currency(-458) * 1.075).value, -4.92);
      expect((Currency(458) * -1.075).value, -4.92);
      expect((Currency(458) * 0).value, 0.0);
    });

    test('division yields correct result', () {
      expect((Currency(458) / 1.075).value, 4.26);
      expect((Currency(-458) / 1.075).value, -4.26);
      expect((Currency(458) / -1.075).value, -4.26);
    });

    test('divide by 0 not supported', () {
      double val;
      try {
        val = (Currency(458) / 0).value;
      } catch (UnsupportedError) {
        val = double.infinity;
      }
      expect(val, double.infinity);
    });

    test('less than operator yields correct result', () {
      expect(Currency(43) < Currency(1435), true);
      expect(Currency(43) < Currency(43), false);
      expect(Currency(43) < Currency(23), false);
    });
    test('greater than operator yields correct result', () {
      expect(Currency(43) > Currency(1435), false);
      expect(Currency(43) > Currency(43), false);
      expect(Currency(43) > Currency(23), true);
    });
    test('less than or equal to operator yields correct result', () {
      expect(Currency(43) <= Currency(1435), true);
      expect(Currency(43) <= Currency(43), true);
      expect(Currency(43) <= Currency(23), false);
    });
    test('greater than or equal to operator yields correct result', () {
      expect(Currency(43) >= Currency(1435), false);
      expect(Currency(43) >= Currency(43), true);
      expect(Currency(43) >= Currency(23), true);
    });

    test('toString method yields correct result', () {
      expect(Currency(43).toString(), "\$0.43");
      expect(Currency(34576).toString(), "\$345.76");
      expect(Currency(-592).toString(), "-\$5.92");
      expect(Currency(43).toString(symbol: '€'), "€0.43");
    });
  });
}
