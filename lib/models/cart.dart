import 'package:flutter/foundation.dart';
import 'catalog.dart';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  double get totalPrice => _items.fold(0, (total, item) => total + item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
} 