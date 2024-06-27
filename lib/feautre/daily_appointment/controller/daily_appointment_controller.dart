// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_smile/apis/apis.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class DailyAppointmentController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  TextEditingController dateController = TextEditingController();
  RxBool isLoading = false.obs;
  var daily = <DailyAppointmentModel>[].obs;
  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
      dateController.text = formattedDate;
      await getDailyAppointment(formattedDate);
    }
  }

  Future<void> getDailyAppointment(String date) async {
    isLoading.value = true;
    try {
      final fetchData = await DailyAppointmentService.getDailyAppointment(date);
      daily.assignAll(fetchData);
      update();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSession(BuildContext context, int clinicID, int referralsID,
      String date, String time) async {
    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));

      await DailyAppointmentService.addSession(
        clinicID,
        referralsID,
        date,
        time,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Success add session'),
        backgroundColor: Palette.primary,
      ));
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Faild add session'),
        backgroundColor: Palette.red,
      ));
    }
  }

  Future<void> updateSession(
      BuildContext context, int sessionID, String status, String note) async {
    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data ...')));

      await DailyAppointmentService.updateSession(sessionID, status, note);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Success update session'),
        backgroundColor: Palette.primary,
      ));
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Faild update session'),
        backgroundColor: Palette.red,
      ));
    }
  }

  void bottomSheetAdd(DailyAppointmentModel dailyAppoint) {
    Get.bottomSheet(
      AddSessionBottomSheet(dailyAppoint: dailyAppoint),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void bottomSheetUpdate(DailyAppointmentModel dailyAppoint) {
    Get.bottomSheet(
      UpdateSessionBottomSheet(dailyAppoint: dailyAppoint),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  List<LaborarotyPicesModel> submitTools = [];
  final LaborarotyPicesController _controller =
      Get.put(LaborarotyPicesController());
  void showLabItemsDialog(
      BuildContext context, DailyAppointmentModel dailyAppoint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Lab Items'),
          content: SingleChildScrollView(
            child: FutureBuilder(
                future: _controller.getRequiredMaterial(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: 300,
                      child: GetBuilder(
                        init: LaborarotyPicesController(),
                        builder: (controller) => ListView.builder(
                            itemCount: controller.requiredMaterial.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                activeColor: Palette.primary,
                                title: Text(
                                    controller.requiredMaterial[index].name),
                                value: controller.isChecked[index],
                                secondary: Image.network(
                                  controller.requiredMaterial[index].image,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                onChanged: (bool? value) {
                                  controller.toggleCheckbox(index, value);
                                },
                              );
                            }),
                      ),
                    );
                  }
                }),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Palette.red)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child:
                  const Text('Send', style: TextStyle(color: Palette.primary)),
              onPressed: () async {
                await submitToolFunc();
                addListTool(dailyAppoint, context);
              },
            ),
          ],
        );
      },
    );
  }

  submitToolFunc() {
    submitTools.clear();
    for (int i = 0; i < _controller.requiredMaterial.length; i++) {
      if (_controller.isChecked[i]) {
        submitTools.add(_controller.requiredMaterial[i]);
      }
    }
  }

  

  Future<void> addListTool(DailyAppointmentModel dailyAppoint, context) async {
    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data ...')));
      if (submitTools.isNotEmpty) {
        await DailyAppointmentService.addListTool(dailyAppoint, submitTools);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Success update session'),
          backgroundColor: Palette.primary,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Faild update session'),
          backgroundColor: Palette.red,
        ));
      }
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Faild add tools'),
        backgroundColor: Palette.red,
      ));
      rethrow;
    }
  }

  void showLabItemsDialogTool(
      BuildContext context, DailyAppointmentModel dailyAppoint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('All tool for session'),
          content: SingleChildScrollView(
            child: FutureBuilder(
                future: _controller.getToolReqDaily(dailyAppoint),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      height: 300,
                      child: GetBuilder(
                        init: LaborarotyPicesController(),
                        builder: (controller) => ListView.builder(
                            itemCount: controller.allTool.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller.allTool[index].name),
                                leading: Image.network(
                                  controller.allTool[index].image,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    );
                  }
                }),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Palette.red)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Ok', style: TextStyle(color: Palette.primary)),
              onPressed: () async {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}

class AddSessionBottomSheet extends StatelessWidget {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final DailyAppointmentController _controller =
      Get.put(DailyAppointmentController());
  final DailyAppointmentModel dailyAppoint;

  AddSessionBottomSheet({super.key, required this.dailyAppoint});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Add Session',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Day',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(31, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }),
                  onChanged: (value) {
                    dayController.text = value.toString();
                  },
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Month',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(12, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                        DateFormat.MMMM().format(DateTime(0, index + 1)),
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }),
                  onChanged: (value) {
                    monthController.text = value.toString();
                  },
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Year',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(100, (index) {
                    int year = DateTime.now().year - index;
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(
                        '$year',
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }),
                  onChanged: (value) {
                    yearController.text = value.toString();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: timeController,
            decoration: const InputDecoration(
              labelText: 'Time',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                final now = DateTime.now();
                final selectedTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                final formattedTime = DateFormat('HH:mm').format(selectedTime);
                timeController.text = formattedTime;
              }
            },
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: Palette.primary,
            minWidth: 200,
            onPressed: () {
              String selectedDate =
                  '${yearController.text}-${monthController.text}-${dayController.text}';
              _controller.addSession(
                context,
                dailyAppoint.sectionModel.clinicID,
                dailyAppoint.referralsModel.id,
                selectedDate,
                timeController.text,
              );
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateSessionBottomSheet extends StatelessWidget {
  final TextEditingController note = TextEditingController();
  final TextEditingController status = TextEditingController();

  final DailyAppointmentController _controller =
      Get.put(DailyAppointmentController());
  final DailyAppointmentModel dailyAppoint;
  List<String> title = [
    "complete",
    "not_complete",
    "last_refarral",
    "didnt_come",
  ];
  UpdateSessionBottomSheet({super.key, required this.dailyAppoint});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Update Session',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Status of session',
                border: OutlineInputBorder(),
              ),
              items: List.generate(4, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    title[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  status.text = title[value];
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: note,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: Palette.primary,
            minWidth: 200,
            onPressed: () {
              _controller.updateSession(
                context,
                dailyAppoint.sessionModel.id,
                status.text,
                note.text,
              );
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
