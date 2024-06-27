class TypeCasesModel {
  final int id;
  final String type;
  final String nameSection;
  final String imageSection;

  TypeCasesModel({
    required this.id,
    required this.type,
    required this.nameSection,
    required this.imageSection,
  });

  factory TypeCasesModel.fromJson(Map<String, dynamic> json) {
    return TypeCasesModel(
      id: json['id'],
      type: json['type'],
      nameSection: json['sections']['name'],
      imageSection: json['sections']['section_image'],
    );
  }
}
