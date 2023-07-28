import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';

class EnvironmentTestWidget extends StatelessWidget {
  final environmentController = Get.find<IEnvironmentController>();

  EnvironmentTestWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      debugPrint("Rebuild test widget");
      return Text(environmentController.currentEnvironment.current.toString());
    });
  }
}
