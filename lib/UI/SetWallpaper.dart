import 'dart:io';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/Utility/Constants.dart';
import '../controllers/ProgressIndicator.dart';

class ImageView extends StatelessWidget {
  final int id;
  final String photographer;
  final String photographer_url;
  final int photographer_id;
  final String large2x;
  final String large;
  final String width;
  final String height;
  final String avg_color;
  ImageView(
      {super.key,
      required this.id,
      required this.photographer,
      required this.photographer_url,
      required this.photographer_id,
      required this.large2x,
      required this.large,
      required this.width,
      required this.height,
      required this.avg_color});

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */

      var status = await Permission.photos.status;
      if (status.isGranted) {
        c.save(this.large2x, this.id);
        // print("Permission is granted");
      } else if (status.isDenied) {
        if (await Permission.photos.request().isGranted) {
          c.save(this.large2x, this.id);

          // Either the permission was already granted before or the user just granted it.
          //  print("Permission was granted");
        }
      }
    } else {
      // print("andrpoid");
      var status = await Permission.photos.status;
      if (status.isGranted) {
        c.save(this.large2x, this.id);
        // print("Permission is granted");
      } else if (status.isDenied) {
        if (await Permission.photos.request().isGranted) {
          c.save(this.large2x, this.id);

          // Either the permission was already granted before or the user just granted it.
          //  print("Permission was granted");
        }
      }
    }
  }

  final indicator c = Get.put(indicator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Set Wallpaper",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Hero(
        tag: this.id,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
                imageUrl: this.large2x,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: theme.neoncolor,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 1.w, right: 1.w),
                child: GestureDetector(
                  onTap: () {
                    openBottomSheet();
                  },
                  child: Container(
                    height: 7.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: HexColor("#303642"),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child:
                          HeroIcon(HeroIcons.chevronUp, color: theme.neoncolor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var filePath;
  void openBottomSheet() {
    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w),
        child: Container(
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: HexColor("#303642"),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 0.5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: theme.neoncolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroIcon(
                      HeroIcons.checkBadge,
                      solid: false,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      this.photographer,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroIcon(
                      HeroIcons.arrowsPointingOut,
                      solid: false,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      this.width + "x" + this.height,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeroIcon(
                      HeroIcons.swatch,
                      solid: false,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Chip(
                      label: Text(
                        this.avg_color,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                      backgroundColor: HexColor(this.avg_color),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _askPermission();
                        var isInitialized =
                            await Appodeal.show(Appodeal.REWARDED_VIDEO);

                        if (isInitialized) {
                          Appodeal.show(Appodeal.REWARDED_VIDEO);
                        } else {
                          //  print("not initialized");
                        }
                      },
                      child: Container(
                        height: 8.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 20,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ],
                          color: HexColor("#3D4552"),
                          //borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.arrowDownCircle,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        openSetwallpaper();
                      },
                      child: Container(
                        height: 8.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 20,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ],
                          color: HexColor("#3D4552"),
                          //borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: HeroIcon(
                            HeroIcons.photo,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openSetwallpaper() {
    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w),
        child: Container(
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: HexColor("#303642"),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 0.5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: theme.neoncolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Material(
                  color: HexColor("#3D4552"),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () async {
                      String result;
// Platform messages may fail, so we use a try/catch PlatformException.
                      try {
                        var isInitialized =
                            await Appodeal.show(Appodeal.REWARDED_VIDEO);

                        if (isInitialized) {
                          Appodeal.show(Appodeal.REWARDED_VIDEO);
                        } else {
                          //  print("not initialized");
                        }
                        result = await AsyncWallpaper.setWallpaper(
                          url: this.large2x,
                          wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                          goToHome: true,
                        )
                            ? 'Wallpaper set'
                            : 'Failed to get wallpaper.';

                        Get.snackbar(
                          "Wallpaper Updated",
                          "",
                          icon: Icon(Icons.check, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } on PlatformException {
                        result = 'Failed to get wallpaper.';
                      }
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 6.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: theme.neoncolor, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Home Screen",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Material(
                  color: HexColor("#3D4552"),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () async {
                      String result;
// Platform messages may fail, so we use a try/catch PlatformException.
                      try {
                        var isInitialized =
                            await Appodeal.show(Appodeal.REWARDED_VIDEO);

                        if (isInitialized) {
                          Appodeal.show(Appodeal.REWARDED_VIDEO);
                        } else {
                          //  print("not initialized");
                        }
                        result = await AsyncWallpaper.setWallpaper(
                          url: this.large2x,
                          wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
                          goToHome: true,
                        )
                            ? 'Wallpaper set'
                            : 'Failed to get wallpaper.';

                        Get.snackbar(
                          "Wallpaper Updated",
                          "",
                          icon: Icon(Icons.check, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } on PlatformException {
                        result = 'Failed to get wallpaper.';
                      }
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 6.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: theme.neoncolor, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Lock Screen",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Material(
                  color: HexColor("#3D4552"),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () async {
                      String result;
// Platform messages may fail, so we use a try/catch PlatformException.
                      try {
                        var isInitialized =
                            await Appodeal.show(Appodeal.REWARDED_VIDEO);

                        if (isInitialized) {
                          Appodeal.show(Appodeal.REWARDED_VIDEO);
                        } else {
                          //  print("not initialized");
                        }
                        result = await AsyncWallpaper.setWallpaper(
                          url: this.large2x,
                          wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
                          goToHome: true,
                        )
                            ? 'Wallpaper set'
                            : 'Failed to get wallpaper.';

                        Get.snackbar(
                          "Wallpaper Updated",
                          "",
                          icon: Icon(Icons.check, color: Colors.white),
                          snackPosition: SnackPosition.TOP,
                        );
                      } on PlatformException {
                        result = 'Failed to get wallpaper.';
                      }
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 6.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: theme.neoncolor, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "Both Screen",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
