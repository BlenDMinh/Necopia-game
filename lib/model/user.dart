import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:necopia/model/animal_data.dart';
import 'package:necopia/model/entity.dart';
import 'package:necopia/service/firebaseAuth_service.dart';

import '../service/user_service.dart';

class NecopiaUser implements Entity {
  static NecopiaUser? _currentUser;
  static NecopiaUser? get currentUser {
    if (FirebaseService().currentUser == null) return null;
    if (_currentUser == null) {
      _currentUser =
          NecopiaUser.fromCredenticalUser(FirebaseService().currentUser!);
      FirebaseFirestore.instance
          .collection('user')
          .where('uid', isEqualTo: _currentUser!.uid)
          .snapshots()
          .listen((event) {
        _currentUser =
            NecopiaUser.fromCredenticalUser(FirebaseService().currentUser!);
      });
    }
    return _currentUser;
  }

  String uid;
  String name;
  String email = "";
  String avatar;
  List<AnimalData>? animalDatas;
  bool isFinishInit = false;

  Future<List<AnimalData>>? _animalDatasFuture;

  NecopiaUser(this.uid, this.name, this.email, this.avatar, this.animalDatas);
  NecopiaUser.fromCredenticalUser(User user)
      : uid = user.uid,
        name = user.displayName ?? "",
        email = user.email ?? "",
        avatar = user.photoURL ?? "" {
    final userService = Get.find<UserService>();
    _animalDatasFuture = userService.getByUid(uid).then((tempUser) async {
      tempUser ??=
          await userService.add(NecopiaUser(uid, name, email, avatar, []));
      await tempUser.ensureInit();
      return animalDatas = tempUser.animalDatas ?? [];
    });
  }

  NecopiaUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = "",
        email = "",
        avatar = "" {
    final futures = (json['animal_datas'] as List<dynamic>)
        .map((e) => AnimalData.fromJson(this, e))
        .toList();
    _animalDatasFuture = Future.wait(futures).then((datas) {
      return animalDatas = datas;
    });
  }

  Future<void> ensureInit() async {
    await _animalDatasFuture;
    isFinishInit = true;
    return;
  }

  @override
  String get id => uid;

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'animal_datas': animalDatas?.map((data) => data.toJson()).toList() ?? []
    };
  }
}
