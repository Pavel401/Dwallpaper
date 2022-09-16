import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallpix/UI/CategorisPage.dart';
import 'package:wallpix/UI/Homepage.dart';
import 'package:wallpix/UI/ProfilePage.dart';
import 'package:wallpix/Utility/Constants.dart';
import 'package:wallpix/controllers/LandingPageController.dart';
import 'package:wallpix/controllers/carosoleController.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyAppView());
}

class MyAppView extends GetView<Controllers> {
  final LandingPageController landingPageController =
      Get.put(LandingPageController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    print("widget initialized");
    //Get.lazyPut(() => Controllers());
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: theme.primaryColor,
            scaffoldBackgroundColor: theme.primaryColor,
            //secondaryHeaderColor:
          ),
          home: Scaffold(
            extendBody: true,
            bottomNavigationBar: Obx(
              () => CustomNavigationBar(
                elevation: 10,
                isFloating: true,
                iconSize: 30.0,
                borderRadius: Radius.circular(12),
                selectedColor: theme.neoncolor,
                strokeColor: Color(0x30040307),
                unSelectedColor: Colors.white,
                backgroundColor: HexColor("#3D4552"),
                items: [
                  CustomNavigationBarItem(
                    icon: const HeroIcon(HeroIcons.home),
                  ),
                  CustomNavigationBarItem(
                    icon: const HeroIcon(HeroIcons.collection),
                  ),
                ],
                currentIndex: landingPageController.tabIndex.value,
                onTap: landingPageController.changeTabIndex,
              ),
            ),
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Obx(
                () => IndexedStack(
                  index: landingPageController.tabIndex.value,
                  children: [
                    HomePage(),
                    Categoris(),
                    //   ProfilePAge(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
