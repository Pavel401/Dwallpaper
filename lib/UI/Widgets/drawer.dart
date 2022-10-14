import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpix/Utility/Constants.dart';

class sidebar extends StatelessWidget {
  sidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuildContext dialogcontext;
    return Drawer(
        backgroundColor: HexColor("#303642"),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 20.h,
                  width: 100.w,
                  decoration: BoxDecoration(color: Colors.black12),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 22.h,
                    child: Lottie.asset("assets/hello.json"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            ListTile(
              leading: const HeroIcon(
                HeroIcons.home,
                color: Colors.white,
                size: 30,
                solid: true,
              ),
              title: const Text('Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Get.back();
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            ListTile(
              leading: const HeroIcon(
                HeroIcons.questionMarkCircle,
                color: Colors.white,
                size: 30,
                solid: true,
              ),
              title: const Text('Privacy Policy',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext dialogcontext) {
                      return AlertDialog(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          content: Container(
                            height: 480,
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: FutureBuilder(
                                    future: DefaultAssetBundle.of(context)
                                        .loadString('assets/PrivacyPolicy.md'),
                                    builder: ((context, snapshot) {
                                      return Markdown(
                                        data: snapshot.data.toString(),
                                      );
                                    }),
                                  ),
                                ),
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                theme.secondaryColor)),
                                    onPressed: () {
                                      Navigator.pop(dialogcontext);
                                    },
                                    icon: const HeroIcon(HeroIcons.check),
                                    label: const Text("Ok"))
                              ],
                            ),
                          ));
                    });
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            ListTile(
              leading: const HeroIcon(
                HeroIcons.arrowLeftOnRectangle,
                color: Colors.white,
                size: 30,
                solid: false,
              ),
              title: const Text('Exit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        content: Container(
                          // color: kPrimaryColor,
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Do you want to exit?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        //  print('yes selected');
                                        exit(0);
                                      },
                                      child: const Text("Yes"),
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#3D4552"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      // print('no selected');
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    child: const Text("No",
                                        style: TextStyle(color: Colors.black)),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ));
  }
}
