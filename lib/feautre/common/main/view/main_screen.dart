import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_smile/core/core.dart';
import 'package:student_smile/feautre/feautre.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MainController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(backgroundColor: Palette.primary),
        drawer: SafeArea(child: drawer(context)),
        body: controller.currentScreen,
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return GetBuilder(
      init: MainController(),
      builder: (controller) => Drawer(
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: const BoxDecoration(
                  color: Palette.primary,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40))),
              child: Row(
                children: [
                  Image.asset(Images.logoAuth, height: 100, width: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Damascus University",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .extension<EXTColors>()!
                                .background,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Dentistry",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .extension<EXTColors>()!
                                  .background,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            component(controller, context, "Home", Images.home, 0),
            component(
                controller, context, "Departments", Images.departiment, 1),
            component(
                controller, context, "Daily appointments", Images.calendar, 2),
            component(controller, context, "User manual", Images.userManual, 0),
            component(
                controller, context, "Laboratory pieces", Images.piece, 4),
            component(controller, context, "About", Images.info, 0),
            component(controller, context, "Settings", Images.settings, 0),
            component(controller, context, "Logout", Images.logout, 7),
          ],
        ),
      ),
    );
  }

  Container component(
    MainController controller,
    BuildContext context,
    String text,
    String image,
    int index,
  ) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(25)),
      child: InkWell(
        onTap: () {
          if (index == 7) {
            Get.back();
            controller.logout();
            return;
          }
          controller.changeSelectedValue(index);
          Get.back();
        },
        child: Row(
          children: [
            Image.asset(
              image,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 25),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
