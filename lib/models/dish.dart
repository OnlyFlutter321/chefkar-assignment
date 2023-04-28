class Dish {
  final String name;
  final double rating;
  final String description;
  final List<String> equipments;
  final String image;
  final int id;

  Dish({
    required this.name,
    required this.rating,
    required this.description,
    required this.equipments,
    required this.image,
    required this.id,
  });

  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      id: map['id'] as int,
      image: map['image'] as String,
      name: map['name'] as String,
      rating: map['rating'] as double,
      description: map['description'] as String,
      equipments: (map['equipments'] as List<dynamic>)
          .map((equipment) => equipment as String)
          .toList(),
    );
  }
}
