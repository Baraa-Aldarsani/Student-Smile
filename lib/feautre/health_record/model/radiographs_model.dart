
class RadiographsModel {
  final int id;
  final String image;

  RadiographsModel({
    required this.id,
    required this.image,
  });
  factory RadiographsModel.fromJson(Map<String, dynamic> json) {
    return RadiographsModel(
      id: json['id'],
      image: json['radiograph_image'],
    );
  }
}
