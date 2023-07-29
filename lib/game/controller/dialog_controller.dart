import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:necopia/environment/environment_controller.dart';

class Dialog {
  String message;
  Dialog(this.message);
}

enum DialogStatus { ready, displaying }

abstract class IDialogController {
  // get Dialog
  void forceDialog();

  DialogStatus get dialogStatus;
  set dialogStatus(DialogStatus status);

  // Dialog stream
  Stream<Dialog> get stream;
}

class DialogController implements IDialogController {
  final environmentController = Get.find<IEnvironmentController>();
  final StreamController<Dialog> _streamController = StreamController();

  static const dialogRate = 0.3;

  DialogController() {
    Stream.periodic(const Duration(seconds: 2), (time) {
      if (dialogStatus == DialogStatus.ready &&
          Random().nextDouble() <= DialogController.dialogRate) {
        _streamController.sink.add(_getDialog());

        dialogStatus = DialogStatus.displaying;
      }
    }).forEach((element) {});
  }

  Dialog _getDialog() {
    return Dialog("Hi");
  }

  @override
  Stream<Dialog> get stream => _streamController.stream;

  @override
  DialogStatus dialogStatus = DialogStatus.ready;

  @override
  void forceDialog() {
    _streamController.sink.add(_getDialog());

    dialogStatus = DialogStatus.displaying;
  }
}
