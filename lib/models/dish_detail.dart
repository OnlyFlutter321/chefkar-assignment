class DishDetail {
  final String name;
  final int id;
  final String timeToPrepare;
  final Ingredients ingredients;

  DishDetail({
    required this.name,
    required this.id,
    required this.timeToPrepare,
    required this.ingredients,
  });

  factory DishDetail.fromMap(Map<String, dynamic> map) {
    return DishDetail(
      name: map['name'] as String,
      id: map['id'] as int,
      timeToPrepare: map['timeToPrepare'] as String,
      ingredients:
          Ingredients.fromMap(map['ingredients'] as Map<String, dynamic>),
    );
  }
}

class Ingredients {
  final List<Spice> vegetables;
  final List<Spice> spices;
  final List<Appliance> appliances;

  Ingredients({
    required this.vegetables,
    required this.spices,
    required this.appliances,
  });

  factory Ingredients.fromMap(Map<String, dynamic> map) {
    return Ingredients(
      vegetables: List<Spice>.from(
        (map['vegetables']).map<Spice>(
          (x) => Spice.fromMap(x as Map<String, dynamic>),
        ),
      ),
      spices: List<Spice>.from(
        (map['spices']).map<Spice>(
          (x) => Spice.fromMap(x as Map<String, dynamic>),
        ),
      ),
      appliances: List<Appliance>.from(
        (map['appliances']).map<Appliance>(
          (x) => Appliance.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Appliance {
  final String name;
  final String image;
  Appliance({
    required this.name,
    required this.image,
  });

  factory Appliance.fromMap(Map<String, dynamic> map) {
    return Appliance(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}

class Spice {
  final String name;
  final String quantity;

  Spice({
    required this.name,
    required this.quantity,
  });

  factory Spice.fromMap(Map<String, dynamic> map) {
    return Spice(
      name: map['name'] as String,
      quantity: map['quantity'] as String,
    );
  }
}
