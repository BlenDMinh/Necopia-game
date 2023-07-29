import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:necopia/environment/air_visual_service.dart';
import 'package:necopia/environment/environment_controller.dart';
import 'package:necopia/game/controller/dialog_set.dart';

class CatDialog {
  String message;
  CatDialog(this.message);
}

enum CatDialogStatus { ready, displaying }

abstract class ICatDialogController {
  // get CatDialog
  void forceDialog();

  void endDialog();

  CatDialogStatus get dialogStatus;
  set dialogStatus(CatDialogStatus status);

  // CatDialog stream
  Stream<CatDialog?> get stream;
}

class CatDialogController implements ICatDialogController {
  final environmentController = Get.find<IEnvironmentController>();
  final StreamController<CatDialog?> _streamController =
      StreamController.broadcast();

  static const dialogRate = 0.1;

  CatDialogController() {
    Stream.periodic(const Duration(seconds: 2), (time) {
      if (dialogStatus == CatDialogStatus.ready &&
          Random().nextDouble() <= CatDialogController.dialogRate) {
        _streamController.sink.add(_getCatDialog());

        dialogStatus = CatDialogStatus.displaying;
      }
    }).forEach((element) {});
  }

  CatDialog _getCatDialog() {
    // TODO: From currentEnvironment in environmentController, return dialog corespond to the env.
    final env = environmentController.currentEnvironment;
    var dialogs = randomKnowledgeDialogs;
    if (env.uv.index > 0 || env.airQuality.index >= AirQuality.sensitive.index)
      dialogs = [];
    if (env.uv.index > 0) dialogs.addAll(uvDialogs);
    if (env.airQuality.index >= AirQuality.sensitive.index)
      dialogs.addAll(aqiDialogs);
    dialogs.shuffle();

    return CatDialog(dialogs.first);
  }

  @override
  Stream<CatDialog?> get stream => _streamController.stream;

  @override
  CatDialogStatus dialogStatus = CatDialogStatus.ready;

  @override
  void forceDialog() {
    _streamController.sink.add(_getCatDialog());

    dialogStatus = CatDialogStatus.displaying;
  }

  @override
  void endDialog() {
    _streamController.sink.add(null);
    dialogStatus = CatDialogStatus.ready;
  }
}
