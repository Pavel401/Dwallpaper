import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/Local.dart';
import 'package:wallpix/Utility/API.dart';
import 'package:wallpix/Utility/Constants.dart';
import 'package:wallpix/Utility/illustrations.dart';
import 'package:wallpix/controllers/LandingPageController.dart';
import 'package:wallpix/controllers/carosoleController.dart';
import 'package:sizer/sizer.dart';

import 'UI/Localcategorypage.dart';

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
        print('Appodeal initialization error:  $errors}');
      });
  Appodeal.setTesting(false);
  Appodeal.setLogLevel(Appodeal.LogLevelNone);
  Appodeal.setAutoCache(Appodeal.INTERSTITIAL, true);
  Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, true);
  Appodeal.setUseSafeArea(true);
}

class MyAppView extends GetView<Controllers> {
  final LandingPageController landingPageController =
      Get.put(LandingPageController(), permanent: false);
// export PATH="$PATH:/Users/pavel_alam/Documents/flutter/bin"
  @override
  Widget build(BuildContext context) {
    // print("widget initialized");
    //Get.lazyPut(() => Controllers());
    return InternetWidget(
        loadingWidget: CustomNoInternetWidget(
          color: theme.primaryColor,
          imageWidget: Lottie.asset('assets/wallpaper.json'),
          textWidget: const Text(
            "Wallpapers are loading",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        offline: CustomNoInternetWidget(
          color: theme.primaryColor,
          imageWidget: Lottie.asset('assets/nointernet.json'),
          textWidget: const Text(
            "Connect to Internet Service",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        // ignore: avoid_print
        whenOffline: () => print('No Internet'),
        // ignore: avoid_print
        whenOnline: () => print('Connected to internet'),
        online: Sizer(
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
                    borderRadius: const Radius.circular(5),
                    selectedColor: theme.neoncolor,
                    strokeColor: const Color(0x30040307),
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
                        local(),
                        Localcategorypage(),
                        //   ProfilePAge(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
