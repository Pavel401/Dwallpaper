import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/Widgets/SearchBar.dart';
import 'package:wallpix/controllers/SearchController.dart';
import 'package:wallpix/controllers/SearchedWallpaperComtroller.dart';
import '../Utility/illustrations.dart';
import 'SetWallpaper.dart';
import 'package:get/get.dart';
import 'package:wallpix/Utility/Constants.dart';

class SearchPage extends GetView<SearchedWallpaperController> {
  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => SearchedWallpaperController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 6.h, bottom: 2.h),
        child: CustomScrollView(
          //  controller: ,
          controller: controller.SearchscrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.neoncolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const HeroIcon(
                          HeroIcons.chevronLeft,
                          color: Colors.black,
                          size: 30,
                        )),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SearchBar(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Search Results",
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  _WallpaperObserver(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Obx _WallpaperObserver() {
    return Obx(
      () {
        if (controller.isWallpaperLoading.value) {
          return Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
            ),
            child: AlignedGridView.count(
              addAutomaticKeepAlives: false,
              physics: const PageScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: HexColor("#C9F560"),
                      highlightColor: HexColor("#C9F560").withOpacity(0.5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      ),
                    ));
              },
            ),
          );
        } else if (controller.isWallpaperDataError.value) {
          return CustomNoInternetWidget(
            color: theme.primaryColor,
            imageWidget: Lottie.asset("assets/tryagain.json"),
            textWidget: const Text(
              "Server is busy, please try again later",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else if (controller.isWallpaperDataError.value) {
          return CustomNoInternetWidget(
            color: theme.primaryColor,
            imageWidget: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_ge2cws3x.json"),
            textWidget: const Text(
              "Server is busy, please try again later",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          // print(controller.carosoleItems);

          return Padding(
              padding: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
              ),
              child: AlignedGridView.count(
                addAutomaticKeepAlives: false,
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: controller.SearchedwallpaperList.length,
                itemBuilder: (context, index) {
                  if (index == controller.SearchedwallpaperList.length - 1 &&
                      controller.isMoreDataAvailable.value == true) {
                    return controller.page < 5
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: Text(
                              "No More Data",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          );
                  } else {
                    return InkWell(
                      onTap: () async {
                        var isInitialized =
                            await Appodeal.show(Appodeal.INTERSTITIAL);

                        if (isInitialized) {
                          Appodeal.show(Appodeal.INTERSTITIAL);
                        } else {
                          //    print("not initialized");
                        }
                        Get.to(
                          () => ImageView(
                            id: controller.SearchedwallpaperList[index]['id'],
                            photographer: controller
                                .SearchedwallpaperList[index]['photographer']
                                .toString(),
                            photographer_url: controller
                                .SearchedwallpaperList[index]
                                    ['photographer_url']
                                .toString(),
                            photographer_id:
                                controller.SearchedwallpaperList[index]
                                    ['photographer_id'],
                            large2x: controller.SearchedwallpaperList[index]
                                    ['src']['portrait']
                                .toString(),
                            large: controller.SearchedwallpaperList[index]
                                    ['src']['portrait']
                                .toString(),
                            width: controller.SearchedwallpaperList[index]
                                    ['width']
                                .toString(),
                            height: controller.SearchedwallpaperList[index]
                                    ['height']
                                .toString(),
                            avg_color: controller.SearchedwallpaperList[index]
                                    ['avg_color']
                                .toString(),
                          ),
                        );
                      },
                      child: Hero(
                        tag: controller.SearchedwallpaperList[index]['id'],
                        child: Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.SearchedwallpaperList[index]
                                      ['src']['medium']
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ));
        }
      },
    );
  }
}
