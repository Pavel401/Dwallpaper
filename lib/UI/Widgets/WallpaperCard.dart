import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/SetWallpaper.dart';

import '../../controllers/carosoleController.dart';

class WallpaperCard extends StatelessWidget {
  const WallpaperCard({
    Key? key,
    required this.controller,
    required this.i,
  }) : super(key: key);

  final Controllers controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var isInitialized = await Appodeal.show(Appodeal.INTERSTITIAL);

        if (isInitialized) {
          Appodeal.show(Appodeal.INTERSTITIAL);
        } else {
          //print("not initialized");
        }

        Get.to(
          () => ImageView(
            id: controller.carosoleItems[i]['id'],
            photographer:
                controller.carosoleItems[i]['photographer'].toString(),
            photographer_url:
                controller.carosoleItems[i]['photographer_url'].toString(),
            photographer_id: controller.carosoleItems[i]['photographer_id'],
            large2x: controller.carosoleItems[i]['src']['portrait'].toString(),
            large: controller.carosoleItems[i]['src']['portrait'].toString(),
            width: controller.carosoleItems[i]['width'].toString(),
            height: controller.carosoleItems[i]['height'].toString(),
            avg_color: controller.carosoleItems[i]['avg_color'].toString(),
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: controller.carosoleItems[i]['src']['landscape'],
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
