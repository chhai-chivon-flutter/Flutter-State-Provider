import 'package:flutter/material.dart';

class CatalogModel {
  static List<String> itemNames = [
    'Acer 15',
    'MSI Stealth 15M 2021',
    'MSI GS66 Stealth 10UE / 2021',
    'MSI GS66 Stealth 10SE / 2020',
    'Predator 15.6',
    'MSI GS66 Stealth 10SF / 2020',
    'MSI GP76 Leopard 10UG',
    'MSI Modern 14 B10MW 2021'
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
