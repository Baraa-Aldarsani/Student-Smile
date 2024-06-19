import 'package:student_smile/feautre/feautre.dart';

class PatientFromSectionModel {
  final PatientModel patientModel;
  final TypeOfCaseseModel typeOfCaseseModel;

  PatientFromSectionModel({
    required this.patientModel,
    required this.typeOfCaseseModel,
  });

  factory PatientFromSectionModel.fromJson(Map<String, dynamic> json) {
    return PatientFromSectionModel(
      patientModel: PatientModel.fromJson(json['patient_cases']['patient']),
      typeOfCaseseModel:
          TypeOfCaseseModel.fromJson(json['patient_cases']['types_of_cases']['sections']),
    );
  }
}
