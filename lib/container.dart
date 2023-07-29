import 'package:get/get.dart';
import 'package:necopia/environment/air_visual_service.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/environment/location_service.dart';
import 'package:necopia/environment/openuv_service.dart';
import 'package:necopia/game/controller/dialog_controller.dart';
import 'package:necopia/service/animal_service.dart';
import 'package:necopia/service/user_service.dart';

void initContainer() {
  Get.put<AnimalService>(AnimalService());
  Get.put<UserService>(UserService());
  Get.put<ILocationService>(LocationService());
  Get.put<IOpenUVService>(OpenUVService());
  Get.put<IAirVisualService>(AirVisualService());
  Get.put<IEnvironmentController>(EnvironmentController());
  Get.put<ICatDialogController>(CatDialogController());
}
