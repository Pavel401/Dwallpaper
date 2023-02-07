import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpix/Utility/Constants.dart';

//"https://res.cloudinary.com/dc0tfxkph/image/upload/v1662962046/pat-whelen--9zbTfPFxoI-unsplash.jpg"
class indicator extends GetxController {
  var progressIndicator = 0.obs;
  save(String url, int id) async {
    Random random = Random();
    openDialog();
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (count, total) {
        progressIndicator.value = ((count / total) * 100).toInt();
      },
    );
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: "WallPix" +
            random.nextInt(5000).toString() +
            " id " +
            id.toString());
  }

  void openDialog() {
    Get.dialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: HexColor("#222222"),
        title: Obx(() => Row(
              children: [
                CircularProgressIndicator(
                  value: progressIndicator.value / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.neoncolor),
                  color: Colors.white,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  progressIndicator.value == 100
                      ? "Wallpaper Downloaded"
                      : "Downloading...",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            )),
        content: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${progressIndicator.value}/100",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            )),
        actions: [
          Obx(() {
            return TextButton(
                child: progressIndicator.value == 100
                    ? Text(
                        "Ok",
                        style: GoogleFonts.poppins(color: theme.neoncolor),
                      )
                    : Text(
                        "Wait",
                        style: GoogleFonts.poppins(color: theme.neoncolor),
                      ),
                onPressed: () {
                  progressIndicator.value == 100
                      ? Navigator.of(Get.overlayContext!, rootNavigator: true)
                          .pop()
                      : Get.snackbar(
                          "Wallpaper is downloading",
                          "Wait until it is downloaded",
                          icon: const Icon(Icons.error, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                });
          })
        ],
      ),
    );
  }
}
