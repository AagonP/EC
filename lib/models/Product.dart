import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description, address;
  final List<String> images;
  final List<Color> colors;
  final double rating, price, distance;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.address,
    required this.distance,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/4w5thy.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Bread",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
    distance: 4.5,
    address: "397a Le Dai Hanh, P.11, District 10, Ho Chi Minh city",
  ),
  Product(
    id: 2,
    images: [
      "assets/images/hoc-nau-pho-gia-truyen.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Pho Ha Noi",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
    distance: 7.9,
    address: "397a Le Dai Hanh, P.11, District 10, Ho Chi Minh city",
  ),
  Product(
    id: 3,
    images: [
      "assets/images/Fried_Chicken-1024x536.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Fried Chicken",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
    distance: 8.5,
    address: "397a Le Dai Hanh, P.11, District 10, Ho Chi Minh city",
  ),
  Product(
    id: 4,
    images: [
      "assets/images/bibimbap-a-popular-Korean-dish.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Korean Food",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: false,
    distance: 1.9,
    address: "397a Le Dai Hanh, P.11, District 10, Ho Chi Minh city",
  ),
];

const String description = "Food Description";
