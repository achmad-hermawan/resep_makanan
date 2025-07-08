class Meal {
  // Properti dari objek Meal
  final String id;             // ID unik untuk setiap resep
  final String name;           // Nama makanan
  final String image;          // URL gambar makanan
  final String instructions;   // Instruksi memasak

  // Konstruktor untuk membuat objek Meal
  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
  });

  // Factory constructor untuk membuat objek Meal dari JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      instructions: json['strInstructions'],
    );
  }

  // Konversi objek Meal ke bentuk Map/JSON
  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': image,
      'strInstructions': instructions,
    };
  }

  // Override metode pembanding agar dua objek Meal dianggap sama jika id-nya sama
  @override
  bool operator ==(Object other) {
    return other is Meal && other.id == id;
  }

  // Override hashCode untuk digunakan pada koleksi seperti Set
  @override
  int get hashCode => id.hashCode;
}
