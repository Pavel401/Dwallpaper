import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/CategorisPage.dart';
import 'package:wallpix/UI/Homepage.dart';
import 'package:wallpix/Utility/API.dart';
import 'package:wallpix/Utility/Constants.dart';
import 'package:wallpix/controllers/LandingPageController.dart';
import 'package:wallpix/controllers/carosoleController.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialization();
  runApp(MyAppView());
}

Future<void> initialization() async {
  Appodeal.initialize(
      appKey: APImanager.appodeal_key,
      adTypes: [
        AppodealAdType.RewardedVideo,
        AppodealAdType.Interstitial,
      ],
      onInitializationFinished: (errors) {
        errors?.forEach((error) => {});
      });
  Appodeal.setTesting(kReleaseMode ? false : true);
  Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
  Appodeal.setAutoCache(Appodeal.INTERSTITIAL, true);
  Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, true);
  Appodeal.setUseSafeArea(true);
}

class MyAppView extends GetView<Controllers> {
  final LandingPageController landingPageController =
      Get.put(LandingPageController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    // print("widget initialized");
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
                //isFloating: true,
                iconSize: 30.0,
                borderRadius: Radius.circular(5),
                selectedColor: theme.neoncolor,
                strokeColor: Color(0x30040307),
                unSelectedColor: Colors.white,
                backgroundColor: HexColor("#3D4552"),
                items: [
                  CustomNavigationBarItem(
                    icon: const HeroIcon(HeroIcons.home),
                  ),
                  CustomNavigationBarItem(
                    icon: const HeroIcon(HeroIcons.rectangleStack),
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
