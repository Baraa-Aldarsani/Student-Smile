class LaborarotyPicesModel {
  final int id;
  final String name;
  final String image;

  LaborarotyPicesModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory LaborarotyPicesModel.fromJson(Map<String, dynamic> json,
      {bool allTool = false}) {
    if (allTool) {
      return LaborarotyPicesModel(
        id: json['student_laboratory_tools']['id'],
        name: json['student_laboratory_tools']['details_of_tool'],
        image: json['student_laboratory_tools']['image_tool'],
      );
    }
    return LaborarotyPicesModel(
      id: json['id'],
      name: json['details_of_tool'],
      image: json['image_tool'],
    );
  }
}
