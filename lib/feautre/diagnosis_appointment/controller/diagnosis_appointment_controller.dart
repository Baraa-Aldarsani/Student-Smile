import 'package:get/get.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/feautre/feautre.dart';

class DiagnosisAppointmentController extends GetxController {
  var diagnosis = <DiagnosisAppointmentModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getDiagnosisApp();
    super.onInit();
  }

  Future<void> getDiagnosisApp() async {
    try {
      isLoading.value = true;

      final List<DiagnosisAppointmentModel> fetchData =
          await DiagnosisAppointmentService.getDiaApp();
      diagnosis.assignAll(fetchData);
      print(diagnosis.length);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
