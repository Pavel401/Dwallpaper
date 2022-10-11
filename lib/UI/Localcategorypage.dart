import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/CategorisView.dart';
import 'package:wallpix/UI/SearchPage.dart';
import 'package:wallpix/Utility/Constants.dart';
import 'package:get/get.dart';

import '../controllers/CategorisController.dart';
import 'Localcategorisviewpage.dart';

class Localcategorypage extends GetView<CategorisWallpaperController> {
  Localcategorypage({super.key});
  List<String> assetPath = [
    "assets/images/flat.png",
    "assets/images/amoled.png",
    "assets/images/illustration.png",
    "assets/images/shapes.png",
    "assets/images/nature.jpeg",
    "assets/images/fluid.jpeg",
    "assets/images/elements.jpeg",
    "assets/images/gradient.jpeg",
  ];
  List<String> title = [
    "Flat",
    "Dark",
    "Illustration",
    "Shapes",
    "Nature",
    "Fluid",
    "Quotes",
    "Gradient"
  ];

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategorisWallpaperController());

    return Scaffold(
      appBar: _buildAppbar(),
      body: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 10.h),
        child: ListView.builder(
          itemCount: title.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                var isInitialized = await Appodeal.show(Appodeal.INTERSTITIAL);

                if (isInitialized) {
                  Appodeal.show(Appodeal.INTERSTITIAL);
                } else {
                  //   print("not initialized");
                }
                Get.to(() => LocalCategoryViewPage(
                      catequery: title[index].toString(),
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 2.h),
                height: 20.h,
                width: double.infinity,
                //color: Colors.red,

                decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(assetPath[index].toString())),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        height: 5.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: HexColor("#3D4552").withOpacity(0.80),
                        ),
                        child: Center(
                          child: Text(
                            title[index].toString(),
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "IMI Walls",
        style: GoogleFonts.nunito(
            //   color: Color.fromRGBO(65, 84, 252, 0.44),
            fontSize: 26,
            letterSpacing: 1,
            fontWeight: FontWeight.w600),
      ),
      actions: [
        InkWell(
          onTap: () async {
            Get.to(SearchPage());
          },
          child: HeroIcon(
            HeroIcons.magnifyingGlassCircle,
            solid: true, // Outlined icons are used by default.
            color: theme.neoncolor,
            size: 22.sp,
          ),
        ),
        SizedBox(
          width: 4.w,
        )
      ],
    );
  }
}
