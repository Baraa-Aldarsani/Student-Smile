import 'package:get/get.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/feautre/feautre.dart';

class PatientController extends GetxController {
  var patient = <PatientModel>[].obs;
  RxBool isLoading = false.obs;
  var patientSession = <DailyAppointmentModel>[].obs;
  @override
  void onInit() {
    getAllPatients();
    super.onInit();
  }

  Future<void> getAllPatients() async {
    isLoading.value = true;
    try {
      final List<PatientModel> fetchData = await PatientSevice.getAllPatients();
      patient.assignAll(fetchData);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPatientSession(int id) async {
    isLoading.value = true;
    try {
      final fetchData = await PatientSevice.getPatientSession(id);
      patientSession.assignAll(fetchData);
      update();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  var allStudent = <UserModel>[].obs;
  Future<void> getAllStudent() async {
    try {
      final List<UserModel> fetchData = await PatientSevice.getAllStudent();
      allStudent.assignAll(fetchData);
    } catch (e) {
      rethrow;
    }
  }
}
