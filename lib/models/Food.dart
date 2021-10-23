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