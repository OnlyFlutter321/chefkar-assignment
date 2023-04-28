class PopularDish {
  final String name;
  final String image;
  final int id;

  PopularDish({
    required this.name,
    required this.image,
    required this.id,
  });

  factory PopularDish.fromMap(Map<String, dynamic> map) {
    return PopularDish(
      name: map['name'] as String,
      image: map['image'] as String,
      id: map['id'] as int,
    );
  }
}
