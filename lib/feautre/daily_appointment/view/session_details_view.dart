import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class SessionDetailsPage extends StatelessWidget {
  final DailyAppointmentModel dailyAppoint;

  SessionDetailsPage({super.key, required this.dailyAppoint});
  final DailyAppointmentController _controller =
      Get.put(DailyAppointmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 490,
              decoration: const BoxDecoration(
                  color: Palette.primaryLight,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Patient Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Baraa Aldarsani'),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Session Time',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(dailyAppoint.sessionModel.time),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Supervisor',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          "${dailyAppoint.supervisorModel.fName} ${dailyAppoint.supervisorModel.lName}"),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Supervisor Notes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(dailyAppoint.sessionModel.supervisorNotes!),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Evaluation',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(dailyAppoint.sessionModel.evaluation != null
                          ? dailyAppoint.sessionModel.evaluation.toString()
                          : '0.0'),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Clinic Number',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(dailyAppoint.sectionModel.clinicNumber.toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Type of Referrals',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(dailyAppoint.referralsModel.type),
                    ],
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(dailyAppoint.sessionModel.status),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedBtn(
                title: "Update Session",
                onPressed: () {
                  _controller.bottomSheetUpdate(dailyAppoint);
                },
                width: 300,
                height: 45,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedBtn(
                title: "Add New Session",
                onPressed: () {
                  _controller.bottomSheetAdd(dailyAppoint);
                },
                width: 300,
                height: 45,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedBtn(
              title: "Show Medical Record",
              onPressed: () {
                Get.to(HealthRecordScreen(dailyAppoint: dailyAppoint));
              },
              width: 300,
              height: 45,
            ),
            const SizedBox(height: 20),
            ElevatedBtn(
              title: "Add tool required",
              onPressed: () {
                _controller.showLabItemsDialog(context, dailyAppoint);
              },
              width: 300,
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
