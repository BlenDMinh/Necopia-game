import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necopia/const/color.dart';
import 'package:necopia/service/firebaseAuth_service.dart';
import 'package:necopia/view/home.dart';
import 'package:necopia/view/register.dart';
import 'package:necopia/widget/textfild.dart';
import 'package:necopia/widget/pixelate/pixel_button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();
  LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  String email = "";
  String password = "";
  IconData passwordIcon = Icons.lock;
  bool isObs = true;

  @override
  void initState() {
    super.initState();
    widget.emailController.text = email;
    widget.passwordController.text = password;
  }

  bool checkValidInfor() {
    if (widget.emailController.text.isEmpty ||
        widget.passwordController.text.isEmpty) {
      Get.snackbar("ERROR", "Please fill full information!");
      return false;
    } else if (!widget.emailController.text.contains("@gmail.com")) {
      Get.snackbar(
          "ERROR", "Email is invalid! Email must be constain '@gmail.com'");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          "Welcome to Necopia again!",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Pixelate",
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
                  alignment: Alignment.bottomCenter,
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
                              isObs = (isObs) ? false : true;
                              passwordIcon =
                                  (isObs) ? Icons.lock : Icons.lock_open;
                            });
                          },
                          width: width / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => ForgotPasswordScreen());
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontFamily: "Minecraft",
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                        color: Colors.white,
                                        offset: Offset(0, 2))
                                  ]),
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                      )
                    ],
                  )),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have any account ?",
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
                              Get.to(RegisterScreen());
                            },
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: 'Sign up',
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
                            "Log in",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Minecraft",
                                color: Colors.white,
                                letterSpacing: 3),
                          ),
                          width: width,
                          onPressed: () {
                            if (checkValidInfor()) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                      child: CircularProgressIndicator()));
                              widget.firebaseService
                                  .signIn(
                                      userEmail:
                                          widget.emailController.text.trim(),
                                      userPassword:
                                          widget.passwordController.text.trim())
                                  .then((value) => {Get.to(() => Home())})
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
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final emailController = TextEditingController();
  final firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgPurple,
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background_lighten.png"),
                filterQuality: FilterQuality.none)),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/images/coin.png',
                  width: width / 1.5,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.none,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "FORGOT PASSWORD?",
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 39,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 4,
                            fontFamily: "Inscryption",
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Don't worry! It happens. Please enter the address associated with your account.",
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            wordSpacing: 3,
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inscryption",
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFild(
                          hintTxt: "@Email",
                          controller: emailController,
                          icon: const Icon(Icons.attach_email_outlined),
                          iconOnTap: () => {Get.back()},
                          width: width / 2),
                      PixelButton(
                          child: Text(
                            "Reset password",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Minecraft"),
                          ),
                          width: width,
                          onPressed: () {
                            if (!emailController.text
                                .trim()
                                .contains("@gmail.com")) {
                              Get.snackbar("ERROR",
                                  "Email is invalid! Email must be constain '@gmail.com'");
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ));
                              firebaseService
                                  .resetPassword(
                                      email: emailController.text.trim())
                                  .then((value) => {
                                        Get.to(() => LoginScreen()),
                                        Get.snackbar("",
                                            "Reset-Password-Email  was sent to your email")
                                      })
                                  .onError((error, stackTrace) {
                                Navigator.pop(context);
                                Get.snackbar("ERROR",
                                    error.toString().replaceRange(0, 11, ""));
                                return {};
                              });
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
