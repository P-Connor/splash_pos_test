import 'package:meta/meta.dart';
import 'package:currency/currency.dart';
import 'package:equatable/equatable.dart';

@immutable
class InventoryItem extends Equatable {
  final String name, displayName, description;
  final Currency price;
  final bool nonTax, archived;

  const InventoryItem({
    required this.name,
    this.displayName = "",
    this.description = "",
    this.price = const Currency(0),
    this.nonTax = false,
    this.archived = false,
  });

  @override
  String toString() {
    return displayName +
        " - Price: " +
        price.toString() +
        (nonTax ? " (NonTaxable)" : "");
  }

  @override
  List<Object?> get props => [
        name,
        displayName,
        description,
        price,
        nonTax,
        archived,
      ];
}
