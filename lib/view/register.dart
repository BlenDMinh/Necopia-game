import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/service/firebaseAuth_service.dart';
import 'package:necopia/view/verify_email.dart';
import 'package:necopia/widget/pixelate/pixel_button.dart';
import 'package:necopia/widget/textfild.dart';
import 'package:necopia/const/color.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool isObs = true;
  IconData passwordIcon = Icons.lock;

  final passwordRequirement =
      "Password must be have at least:\n* 8 Characters\n* 1 Uppercase character\n* 1 Lowercase character\n* 1 Numeric number\n* 1 Special character:"
      r'!@#\$&*~';

  @override
  void initState() {
    super.initState();
    widget.emailController.text = email;
    widget.passwordController.text = password;
    widget.confirmPassController.text = confirmPassword;
  }

  bool passwordStrengthChecker() {
    return true;
  }

  bool userValidate() {
    if (widget.emailController.text.isEmpty ||
        widget.passwordController.text.isEmpty ||
        widget.confirmPassController.text.isEmpty) {
      Get.snackbar("ERROR", "Please fill full information");
      return false;
    } else if (!widget.emailController.text.contains("@gmail.com")) {
      Get.snackbar(
          "ERROR", "Email is invalid! Email must be constain '@gmail.com'");
      return false;
    } else if (widget.confirmPassController.text
            .compareTo(widget.passwordController.text) !=
        0) {
      Get.snackbar("ERROR",
          "Password confirmation dose not match. Click to icon \"LOCK\" to show the password");
      return false;
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(widget.passwordController.text)) {
      Get.snackbar("ERROR",
          "Password format is incorrect. Please click to icon \"INFORMATION\" to see detail password format detail");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/background_lighten.png"),
                  filterQuality: FilterQuality.none)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Please fill in the form!",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontFamily: "Minecraft",
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      color: primaryPurpleLighter,
                                      offset: Offset(0, 4))
                                ]),
                            maxLines: 2,
                          ),
                        ],
                      ))),
              Expanded(
                flex: 3,
                child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFild(
                            hintTxt: "Email",
                            controller: widget.emailController,
                            icon: Image.asset(
                              "assets/icon/letter.png",
                              filterQuality: FilterQuality.none,
                              color: Colors.grey.shade800,
                            ),
                            width: width / 2),
                        TextFild(
                            hintTxt: "Password",
                            controller: widget.passwordController,
                            icon: Image.asset(
                              "assets/icon/lock.png",
                              filterQuality: FilterQuality.none,
                              color: Colors.grey.shade800,
                            ),
                            isObs: isObs,
                            iconOnTap: () {
                              setState(() {
                                email = widget.emailController.text;
                                password = widget.passwordController.text;
                                confirmPassword =
                                    widget.confirmPassController.text;
                                isObs = (isObs) ? false : true;
                                passwordIcon =
                                    (isObs) ? Icons.lock : Icons.lock_open;
                              });
                            },
                            width: width / 2),
                        TextFild(
                            hintTxt: "Confirm password",
                            controller: widget.confirmPassController,
                            icon: Image.asset(
                              "assets/icon/lock.png",
                              filterQuality: FilterQuality.none,
                              color: Colors.grey.shade800,
                            ),
                            isObs: isObs,
                            iconOnTap: () {
                              Get.snackbar("Password format detail",
                                  passwordRequirement);
                            },
                            width: width / 2),
                      ],
                    )),
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account ?",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Minecraft",
                                    shadows: [
                                      Shadow(
                                          color: Colors.white,
                                          offset: Offset(0, 2))
                                    ]),
                                textAlign: TextAlign.end),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: const TextSpan(children: [
                                  TextSpan(
                                      text: 'Log in',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: primaryPurpleDarker,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "Minecraft",
                                          shadows: [
                                            Shadow(
                                                color: Colors.white,
                                                offset: Offset(0, 2))
                                          ])),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.bottomCenter,
                        child: PixelButton(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Minecraft",
                                  color: Colors.white,
                                  letterSpacing: 3),
                            ),
                            width: width,
                            onPressed: () {
                              if (userValidate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                        child: CircularProgressIndicator()));
                                widget.firebaseService
                                    .signUp(
                                        userEmail:
                                            widget.emailController.text.trim(),
                                        userPassword: widget
                                            .passwordController.text
                                            .trim())
                                    .then((value) =>
                                        {Get.to(() => VerifyEmailScreen())})
                                    .onError((error, stackTrace) {
                                  Navigator.pop(context);
                                  Get.snackbar("ERROR",
                                      error.toString().replaceRange(0, 11, ""));
                                  return {};
                                });
                              }
                            }),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
