class Food {
  final int id;
  final String title;
  final List<String> images;
  final double price;
  final bool isFavourite;

  Food({
    required this.id,
    required this.images,
    this.isFavourite = false,
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
      isFavourite: true,
  ),
  Food(
      id: 2,
      images: [
        "assets/images/hoc-nau-pho-gia-truyen.jpg",
      ],
      title: "Pho",
      price: 50.5,
    isFavourite: false,
  ),
  Food(
      id: 3,
      images: [
        "assets/images/Fried_Chicken-1024x536.png",
      ],
      title: "Fried Chicken",
      price: 36.55,
      isFavourite: true,
  ),
  Food(
      id: 4,
      images: [
        "assets/images/bibimbap-a-popular-Korean-dish.jpg",
      ],

      title: "Korean Food",
      price: 20.20,
      isFavourite: true,
  ),
  Food(
    id: 5,
    images: [
      "assets/images/tra-sua-truyen-thong.jpg",
    ],

    title: "Milk Tra",
    price: 10.5,
    isFavourite: false,
  ),
];
