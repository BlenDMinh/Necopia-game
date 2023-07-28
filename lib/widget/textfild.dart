import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:necopia/widget/pixelate/pixel_container.dart';

Widget TextFild(
    {required String hintTxt,
    required TextEditingController controller,
    bool isObs = false,
    TextInputType? keyBordType,
    required Widget icon,
    required double width,
    Function()? iconOnTap}) {
  return PixelContainer(
    padding: const EdgeInsets.only(left: 25, right: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            obscureText: isObs,
            keyboardType: keyBordType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "Minecraft",
                letterSpacing: 2),
          ),
        ),
        CupertinoButton(minSize: 20, onPressed: iconOnTap, child: icon),
      ],
    ),
  );
}
