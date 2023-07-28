import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/service/firebaseAuth_service.dart';
import 'package:necopia/view/home.dart';
import 'package:necopia/view/register.dart';

import '../const/color.dart';

class VerifyEmailScreen extends StatefulWidget {
  VerifyEmailScreen({super.key});
  final firebaseService = FirebaseService();

  @override
  State<StatefulWidget> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResend = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    print("Init Verifiy Email");

    isEmailVerified = widget.firebaseService.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) async {
        await widget.firebaseService.reloadUser();
        setState(() {
          isEmailVerified = widget.firebaseService.currentUser!.emailVerified;
        });

        if (isEmailVerified) timer?.cancel();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future<void> sendVerificationEmail() async {
    await widget.firebaseService.sendEmailVerification().onError(
        (error, stackTrace) =>
            Get.snackbar("ERROR", error.toString().replaceRange(0, 11, "")));
    setState(() => canResend = false);
    await Future.delayed(const Duration(seconds: 5));
    setState(() => canResend = true);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return (isEmailVerified)
        ? Home()
        : SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background_lighten.png"),
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Image.asset(
                              'assets/images/coin.png',
                              width: width / 1.5,
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.none,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Check your email",
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 34,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Inscryption",
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "We have sent a verify email to your email.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: "Inscryption",
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width / 1.4,
                                  height: 50,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (canResend) {
                                        sendVerificationEmail();
                                      }
                                    },
                                    icon: const Icon(
                                        Icons.mark_email_unread_outlined),
                                    label:
                                        const Text("Resend Verification Email",
                                            style: TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inscryption",
                                            )),
                                    style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        foregroundColor: (canResend)
                                            ? Colors.white
                                            : Colors.redAccent,
                                        backgroundColor: (canResend)
                                            ? primaryPurpleDarker
                                            : Colors.black87,
                                        shadowColor: Colors.black,
                                        elevation: 3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: width / 1.1,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "Did not receive the email? Check your spam filter, or ",
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              fontFamily: "Inscryption",
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                        TextSpan(
                                            text: "try another email address.",
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontFamily: "Inscryption",
                                                letterSpacing: 2,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                widget.firebaseService
                                                    .deleteCurrentUser()
                                                    .then((value) => Get.to(
                                                        () => RegisterScreen()))
                                                    .onError(
                                                        (error, stackTrace) {
                                                  Navigator.pop(context);
                                                  Get.snackbar(
                                                      "ERROR",
                                                      error
                                                          .toString()
                                                          .replaceRange(
                                                              0, 11, ""));
                                                  return null;
                                                });
                                              })
                                      ]),
                                      maxLines: 3,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ))
                        ]),
                  ),
                )),
          );
  }
}
