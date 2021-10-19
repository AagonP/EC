import 'package:flutter/material.dart';

class Store {
  final int id;
  final String name, address;
  final String image;
  final double rating;
  final bool isFavourite;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    this.rating = 0.0,
    this.isFavourite = false,
  });
}

// Our demo Products
Store demoStore = Store(
  id: 1,
  name: "Chicken Popeyes - Le Dai Hanh",
  image: "assets/images/ps4_console_white_1.png",
  address: "397a Le Dai Hanh, P.11, District 10, Ho Chi Minh city",
  rating: 4.8,
  isFavourite: true,
);
