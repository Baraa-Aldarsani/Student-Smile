class DepartmentModel {
  final int id;
  final String name;

  final String email;
  final String image;
  final String details;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.details,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['section_image'],
      details: json['details'],
    );
  }
}
