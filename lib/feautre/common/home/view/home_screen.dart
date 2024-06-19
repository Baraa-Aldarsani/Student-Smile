import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _headerWidget(),
            _bodyWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Palette.primaryLight),
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 13, top: 10),
        child: _buildButtons(),
      ),
    );
  }

  Widget _buildButtons() {
    return _buildMaterialButton(
      label: 'Continue',
      backgroundColor: Palette.primary,
      textColor: Palette.primaryLight,
      onPressed: () {},
    );
  }

  Widget _buildMaterialButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return MaterialButton(
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: backgroundColor),
      ),
      color: backgroundColor,
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Obx(
      () => FutureBuilder(
          future: _controller.selectedIndexButtons.value == 0
              ? _controller.getPatientFromDepartment()
              : _controller.selectedIndexButtons.value == 1
                  ? _controller.getPatientFromStudent()
                  : _controller.getPatientFromStudent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Palette.grey,
                        highlightColor: Palette.primaryLight,
                        child: Container(
                          height: 62,
                          decoration: const BoxDecoration(
                            color: Palette.primaryLight,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                    itemCount: _controller.selectedIndexButtons.value == 0
                        ? _controller.patienSection.length
                        : _controller.selectedIndexButtons.value == 1
                            ? _controller.patienStudent.length
                            : _controller.patienStudent.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 62,
                        decoration: const BoxDecoration(
                          color: Palette.primaryLight,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Obx(
                          () => ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl:
                                    _controller.selectedIndexButtons.value == 0
                                        ? _controller.patienSection[index]
                                            .patientModel.image
                                        : _controller.selectedIndexButtons
                                                    .value ==
                                                1
                                            ? _controller.patienStudent[index]
                                                .patientModel.image
                                            : _controller.patienStudent[index]
                                                .patientModel.image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 200,
                                height: double.infinity,
                              ),
                            ),
                            title: Text(_controller
                                        .selectedIndexButtons.value ==
                                    0
                                ? "${_controller.patienSection[index].patientModel.fName} ${_controller.patienSection[index].patientModel.lName}"
                                : _controller.selectedIndexButtons.value == 1
                                    ? "${_controller.patienStudent[index].patientModel.fName} ${_controller.patienStudent[index].patientModel.lName}"
                                    : "${_controller.patienStudent[index].patientModel.fName} ${_controller.patienStudent[index].patientModel.lName}"),
                            subtitle: Text(
                                _controller.selectedIndexButtons.value == 0
                                    ? _controller.patienSection[index]
                                        .typeOfCaseseModel.nameSection
                                    : _controller.selectedIndexButtons.value ==
                                            1
                                        ? _controller.patienStudent[index]
                                            .typeOfCaseseModel.nameSection
                                        : _controller.patienStudent[index]
                                            .typeOfCaseseModel.nameSection),
                            trailing: Checkbox(
                              activeColor: Palette.primary,
                              value: _controller.selectedIndexButtons.value == 0
                                  ? _controller.checkedItemsDepart[index]
                                  : _controller.selectedIndexButtons.value == 1
                                      ? _controller.checkedItemsStud[index]
                                      : _controller.checkedItemsStud[index],
                              onChanged: (value) {
                                _controller.selectedIndexButtons.value == 0
                                    ? _controller.toggleChecked(index, value)
                                    : _controller.selectedIndexButtons.value ==
                                            1
                                        ? _controller.toggleCheckedStud(
                                            index, value)
                                        : _controller.toggleCheckedStud(
                                            index, value);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                ),
              );
            }
          }),
    );
  }

  SizedBox _headerWidget() {
    return SizedBox(
      height: 40,
      child: GetBuilder(
        init: HomeController(),
        builder: (controller) => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.changeColor(index);
                controller.refreshPage();
              },
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              splashColor: Palette.primaryLight,
              child: Container(
                width: 108,
                decoration: BoxDecoration(
                    color: controller.getColorButtons(index),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: Palette.primary)),
                alignment: Alignment.center,
                child: Text(
                  controller.title[index],
                  style: TextStyle(
                      color: controller.getColorText(index), fontSize: 13),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
        ),
      ),
    );
  }
}
