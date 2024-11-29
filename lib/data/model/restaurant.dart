class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String get pictureUrlSmall =>
      "https://restaurant-api.dicoding.dev/images/small/$pictureId";

  String get pictureUrlMedium =>
      "https://restaurant-api.dicoding.dev/images/medium/$pictureId";

  String get pictureUrlLarge =>
      "https://restaurant-api.dicoding.dev/images/large/$pictureId";

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"] ?? '', // Default nilai kosong jika null
      name: json["name"] ?? 'Unknown', // Default nama jika null
      description: json["description"] ??
          'No description available', // Default deskripsi
      pictureId:
          json["pictureId"] ?? '', // Default kosong jika tidak ada gambar
      city: json["city"] ?? 'Unknown city', // Default kota jika null
      rating:
          (json["rating"] ?? 0.0).toDouble(), // Default rating 0.0 jika null
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "pictureId": pictureId,
      "city": city,
      "rating": rating,
    };
  }
}
