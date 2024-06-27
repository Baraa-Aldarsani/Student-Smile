import 'package:student_smile/feautre/feautre.dart';

class PatientFromSectionModel {
  final int id;
  final PatientModel patientModel;
  final TypeOfCaseseModel typeOfCaseseModel;

  PatientFromSectionModel({
    required this.id,
    required this.patientModel,
    required this.typeOfCaseseModel,
  });

  factory PatientFromSectionModel.fromJson(Map<String, dynamic> json) {
    return PatientFromSectionModel(
      id: json['id'],
      patientModel: PatientModel.fromJson(json['patient_cases']['patient']),
      typeOfCaseseModel: TypeOfCaseseModel.fromJson(
          json['patient_cases']['types_of_cases']['sections']),
    );
  }
}
