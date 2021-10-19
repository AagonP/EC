class Food {
  final int id;
  final String name, image, description;
  final double price;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });
}

// Our demo Products

List<Food> demoFoods = [
  Food(
    id: 1,
    name: "Chicken deep fried with fish sauce",
    image: "assets/images/tshirt.png",
    description: description,
    price: 44.0,
  ),
  Food(
    id: 2,
    name: "Fried chicken",
    image: "assets/images/ps4_console_blue_3.png",
    description: description,
    price: 44.0,
  ),
  Food(
    id: 3,
    name: "Big-sized chips",
    image: "assets/images/shoes2.png",
    description: description,
    price: 44.0,
  ),
  Food(
    id: 4,
    name: "Average-sized chips",
    image: "assets/images/wireless headset.png",
    description: description,
    price: 44.0,
  ),
];

const String description = "Some random bullshit description …";
