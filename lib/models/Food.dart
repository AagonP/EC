class Food {
  final String id;
  final String title, description;
  final List<String> images;
  final double price;

  Food({
    required this.id,
    required this.images,
    required this.title,
    required this.price,
    required this.description,
  });
}

List<Food> demoFoods = [
  Food(
    id: '1',
    images: [
      "assets/images/4w5thy.jpg",
    ],
    title: "Bread",
    price: 64.99,
    description:
        "This bread is 100% authenticated by Gordon Ramsay, you would die (not literally) by eating it, mlem mlem mlem mlem mlem mlem.",
  ),
  Food(
    id: '2',
    images: [
      "assets/images/hoc-nau-pho-gia-truyen.jpg",
    ],
    title: "Pho",
    price: 50.5,
    description:
        "Pho is one of the most famous Vietnamese food, it is flavorful and gives you a relaxing feeling when eating.",
  ),
  Food(
    id: '3',
    images: [
      "assets/images/Fried_Chicken-1024x536.png",
    ],
    title: "Fried Chicken",
    price: 36.55,
    description: "I'm out of idea. :D",
  ),
  Food(
    id: '4',
    images: [
      "assets/images/bibimbap-a-popular-Korean-dish.jpg",
    ],
    title: "Korean Food",
    price: 20.20,
    description: "I'm out of idea. :D",
  ),
  Food(
    id: '5',
    images: [
      "assets/images/tra-sua-truyen-thong.jpg",
    ],
    title: "Milk Tra",
    price: 10.5,
    description: "I'm out of idea. :D",
  ),
];
