import 'package:student_smile/feautre/health_record/health_record.dart';

class HealthRecordModel {
  List<RadiographsModel>? radiographs;
  List<GetMedicineModel>? medicine;
  List<DiseasesModel>? diseases;

  HealthRecordModel({
    this.radiographs,
    this.medicine,
    this.diseases,
  });

  factory HealthRecordModel.fromJson(Map<dynamic, dynamic> json) {
    var radioList = json['Radiograph'] as List<dynamic>;
    List<RadiographsModel> radiograph = radioList
        .map((radiographs) => RadiographsModel.fromJson(radiographs))
        .toList();

    var medicineList = json['PatientMedication'] as List<dynamic>;
    List<GetMedicineModel> medicineData = medicineList
        .map((medicine) => GetMedicineModel.fromJson(medicine))
        .toList();
    var diseList = json['PatientDisease'] as List<dynamic>;
    List<DiseasesModel> diseasesData = diseList
        .map((diseases) => DiseasesModel.fromJson(diseases, healthRecord: 1))
        .toList();
    return HealthRecordModel(
      radiographs: radiograph,
      medicine: medicineData,
      diseases: diseasesData,
    );
  }
}
