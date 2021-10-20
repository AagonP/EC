class Food {
  final int id;
  final String title;
  final List<String> images;
  final double price;

  Food({
    required this.id,
    required this.images,
    required this.title,
    required this.price,
  });

}
List<Food> demoFoods = [
  Food(
      id: 1,
      images: [
        "assets/images/4w5thy.jpg",
      ],
      title: "Bread",
      price: 64.99,
  ),
  Food(
      id: 2,
      images: [
        "assets/images/hoc-nau-pho-gia-truyen.jpg",
      ],
      title: "Pho",
      price: 50.5,
  ),
  Food(
      id: 3,
      images: [
        "assets/images/Fried_Chicken-1024x536.png",
      ],
      title: "Fried Chicken",
      price: 36.55,
  ),
  Food(
      id: 4,
      images: [
        "assets/images/bibimbap-a-popular-Korean-dish.jpg",
      ],

      title: "Korean Food",
      price: 20.20,
  ),
  Food(
    id: 5,
    images: [
      "assets/images/tra-sua-truyen-thong.jpg",
    ],

    title: "Milk Tra",
    price: 10.5,
  ),
];
