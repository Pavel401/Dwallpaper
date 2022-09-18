import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/Homepage.dart';
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
          print("Permission was granted");
        }
      }
    } else {
      print("andrpoid");
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
                      HeroIcons.badgeCheck,
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
                      HeroIcons.arrowsExpand,
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
                      HeroIcons.colorSwatch,
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
                GestureDetector(
                  onTap: () async {
                    _askPermission();
                    var isInitialized =
                        await Appodeal.show(Appodeal.REWARDED_VIDEO);

                    if (isInitialized) {
                      Appodeal.show(Appodeal.REWARDED_VIDEO);
                    } else {
                      print("not initialized");
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
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ],
                      color: HexColor("#3D4552"),
                      //borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeroIcon(
                          HeroIcons.download,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
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
}
