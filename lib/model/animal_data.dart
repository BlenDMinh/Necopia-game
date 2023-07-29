import 'package:get/get.dart';
import 'package:necopia/model/animal.dart';
import 'package:necopia/model/user.dart';
import 'package:necopia/service/animal_service.dart';

class AnimalData {
  late Animal animal;
  late NecopiaUser? user;
  double food = 1.0;
  int level = 0;
  int currentExp = 0;
  int nextLevelExp = 1000;

  bool _isActive = false;

  set isActive(bool data) {
    _isActive = data;
    if (isActive) {
      // Activate food drain
    } else {
      // Deactivate food drain
    }
  }

  bool get isActive {
    return _isActive;
  }

  AnimalData(this.animal, this.user);

  AnimalData._(this.animal, this.user, this.food, this.level, this.currentExp,
      this.nextLevelExp, this._isActive);

  static Future<AnimalData> fromJson(
      NecopiaUser user, Map<String, dynamic> json) async {
    final animalSerivce = Get.find<AnimalService>();
    final animalId = json['animal_id'];
    final animal = await animalSerivce.getById(animalId);
    if (animal == null) throw 'Animal not found';

    return AnimalData._(animal, user, json['food'] ?? 0, json['level'],
        json['current_exp'], json['next_level_exp'], json['isActive']);
  }

  Map<String, dynamic> toJson() {
    return {
      'animal_id': animal.id,
      'uid': user!.uid,
      'level': level,
      'current_exp': currentExp,
      'next_level_exp': nextLevelExp,
      'isActive': isActive
    };
  }
}
