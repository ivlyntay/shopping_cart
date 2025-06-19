import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Item {
  final int id;
  final String name;
  final double price;
  final Color color;
  final String imageUrl;

  const Item({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
    required this.imageUrl,
  });
}

class CatalogModel extends ChangeNotifier {
 final List<Item> _items = [
  Item(
    id: 1,
    name: 'Lemon Soda',
    price: 2.5,
    color: Colors.yellow,
    imageUrl: 'assets/lemon_soda.png', 
  ),
  Item(
    id: 2,
    name: 'Berry Tale',
    price: 2.8,
    color: Colors.pinkAccent,
    imageUrl: 'assets/berry_tale.jpeg',
  ),
  Item(
    id: 3,
    name: 'Tea Tales',
    price: 3.0,
    color: Colors.pink,
    imageUrl: 'assets/tea_tales.jpeg',
  ),
  Item(
    id: 4,
    name: 'Lil\' Lemon',
    price: 2.7,
    color: Colors.yellowAccent,
    imageUrl: 'assets/lil_lemon.jpg', 
  ),
  Item(
    id: 5,
    name: 'Tropical Diary',
    price: 3.8,
    color: Colors.greenAccent,
    imageUrl: 'assets/tropicana_diary.jpeg', 
  ),
  Item(
    id: 6,
    name: 'Coke Lemonade',
    price: 4.5,
    color: Colors.greenAccent,
    imageUrl: 'assets/code_lemonade.jpg', 
  ),
];

  List<Item> get items => List.unmodifiable(_items);

  Item getByPosition(int position) {
    return _items[position];
  }

  Item getById(int id) {
    return _items.firstWhere((item) => item.id == id);
  }
} 