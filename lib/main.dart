import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/container.dart';
import 'package:necopia/firebase_options.dart';
import 'package:necopia/service/firebaseAuth_service.dart';
import 'package:necopia/view/home.dart';
import 'view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initContainer();

  runApp(const GetMaterialApp(
    home: MainApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (FirebaseService().isLogin()) ? Home() : const SplashScreen();
  }
}
