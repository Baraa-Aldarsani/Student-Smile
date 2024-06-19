class LaborarotyPicesModel {
  final int id;
  final String name;
  final String image;

  LaborarotyPicesModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory LaborarotyPicesModel.fromJson(Map<String, dynamic> json) {
    return LaborarotyPicesModel(
      id: json['id'],
      name: json['details_of_tool'],
      image: json['image_tool'],
    );
  }
}
