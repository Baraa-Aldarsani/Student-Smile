import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class AddLaborarotyPices extends StatelessWidget {
  AddLaborarotyPices({super.key});
  final LaborarotyPicesController _controller =
      Get.put(LaborarotyPicesController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.background,
        title: const Text("Add Equipment"),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _controller.name,
                  title: "Name equipment",
                  icon: Icons.toll,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: _controller.image == null
                        ? const SizedBox()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: Image.file(
                                File(_controller.image!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedBtn(
                  title: "Add picture",
                  onPressed: () {
                    _controller.selectImage(context);
                  },
                  width: 160,
                  height: 40,
                ),
                const SizedBox(height: 30),
                ElevatedBtn(
                  title: "Add",
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _controller.image != null) {
                      await _controller.addEquipment(
                          _controller.name.text, _controller.image!);
                      _controller.getRequiredMaterial();
                    }
                  },
                  width: 260,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
