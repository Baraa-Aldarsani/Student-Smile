class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? birthday;
  String? year;
  String? specialization;
  int? unNumber;
  String? token;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.birthday,
    this.year,
    this.specialization,
    this.unNumber,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
      {bool getProfile = false}) {
    if (getProfile) {
      return UserModel(
        firstName: (json['first_name'] != null) ? json['first_name'] : '',
        lastName: (json['last_name'] != null) ? json['last_name'] : '',
        email: json['email'],
        gender: (json['gender'] != null) ? json['gender'] : '',
        birthday: (json['birthday'] != null) ? json['birthday'] : '',
        year: (json['year'] != null) ? json['year'] : '',
        specialization:
            (json['specialization'] != null) ? json['specialization'] : '',
        unNumber: json['university_number'],
      );
    }
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
      'specialization': specialization,
      'token': token,
    };
  }
}
