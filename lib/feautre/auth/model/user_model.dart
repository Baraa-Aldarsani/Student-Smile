class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? birthday;
  String? year;
  String? specialization;
  String? image;
  String? token;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.birthday,
    this.year,
    this.specialization,
    this.image,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      token: json['token'],
    );
  }

  toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'year': year,
      'image': image,
      'specialization': specialization,
      'token': token,
    };
  }
}
