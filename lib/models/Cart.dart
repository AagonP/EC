import 'package:flutter/material.dart';

import 'Food.dart';

class Cart {
  final Food product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoFoods[0], numOfItem: 2),
  Cart(product: demoFoods[1], numOfItem: 1),
  Cart(product: demoFoods[2], numOfItem: 3),
];
