class Store {
  final int id;
  final String title;
  final List<String> images;
  final double rating, distance;
  final bool isPopular;

  Store({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isPopular = false,
    required this.title,
    required this.distance,
  });
}

// Our demo Products

List<Store> demoStores = [
  Store(
      id: 1,
      images: [
        "assets/images/4w5thy.jpg",
      ],
      title: "Banh mi Sai Gon",
      rating: 4.8,
      isPopular: true,
      distance: 4.5
  ),
  Store(
      id: 2,
      images: [
        "assets/images/hoc-nau-pho-gia-truyen.jpg",
      ],
      title: "Pho Ha Noi",
      rating: 4.1,
      isPopular: false,
      distance: 7.9
  ),
  Store(
      id: 3,
      images: [
        "assets/images/Fried_Chicken-1024x536.png",
      ],
      title: "KFC",
      rating: 4.1,
      isPopular: true,
      distance: 8.5
  ),
  Store(
      id: 4,
      images: [
        "assets/images/bibimbap-a-popular-Korean-dish.jpg",
      ],
      title: "Hanuri",
      rating: 4.1,
      isPopular:true,
      distance: 1.9
  ),
  Store(
      id: 5,
      images: [
        "assets/images/tra-sua-truyen-thong.jpg",
      ],
      title: "Gong Cha",
      rating: 4.8,
      isPopular:true,
      distance: 3.2
  ),
  Store(
      id: 6,
      images: [
        "assets/images/tra-sua-truyen-thong.jpg",
      ],
      title: "Test Store",
      rating: 0.0,
      isPopular:false,
      distance: 0.0
  ),
  Store(
      id: 7,
      images: [
        "assets/images/tra-sua-truyen-thong.jpg",
      ],
      title: "Test Store",
      rating: 0.0,
      isPopular:false,
      distance: 0.0
  ),
];



