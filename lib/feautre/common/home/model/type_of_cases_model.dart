class TypeOfCaseseModel {
  final int id;
  final String nameSection;

  TypeOfCaseseModel({
    required this.id,
    required this.nameSection,
  });

  factory TypeOfCaseseModel.fromJson(Map<String, dynamic> json) {
    return TypeOfCaseseModel(id: json['id'], nameSection: json['name']);
  }
}
