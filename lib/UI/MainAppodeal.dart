import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/Interstitial.dart';
import 'package:wallpix/Utility/API.dart';

class AppodealDemoApp extends StatefulWidget {
  @override
  _AppodealDemoAppState createState() => _AppodealDemoAppState();
}

class _AppodealDemoAppState extends State<AppodealDemoApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> initialization() async {
    Appodeal.setTesting(kReleaseMode ? false : true); //only not release mode
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);

    Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
    Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, false);
    Appodeal.setUseSafeArea(true);

    Appodeal.initialize(
        appKey: APImanager.appodeal_key,
        adTypes: [
          AppodealAdType.RewardedVideo,
          AppodealAdType.Interstitial,
          AppodealAdType.Banner,
          AppodealAdType.MREC
        ],
        onInitializationFinished: (errors) {
          errors?.forEach((error) => print(error.desctiption));
          print("onInitializationFinished: errors - ${errors?.length ?? 0}");
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Appodeal Flutter Demo'),
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 4.0, right: 4.0, top: 8.0, bottom: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    initialization();
                  },
                  child: const Text('INITIALIZATION'),
                ),
              ),
            ],
          ),
          //Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 4.0, right: 4.0, top: 8.0, bottom: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () async {
                    Get.to(InterstitialPage());
                  },
                  child: const Text('INTERSTITIAL'),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
