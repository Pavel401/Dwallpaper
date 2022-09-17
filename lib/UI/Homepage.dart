import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/SearchPage.dart';
import 'package:wallpix/UI/SetWallpaper.dart';
import 'package:wallpix/Utility/Constants.dart';
import 'package:wallpix/controllers/carosoleController.dart';
import 'package:sizer/sizer.dart';

import '../controllers/Appodeal.dart';

class HomePage extends GetView<Controllers> {
  HomePage({super.key});
  AppodealAds appodealAds = Get.put(AppodealAds());

  @override
  Widget build(BuildContext context) {
    print("widget initialized");
    Get.lazyPut(() => Controllers());

    return Scaffold(
        extendBody: true,
        appBar: _buildAppbar(),
        body: CustomScrollView(
          // controller: Controllers.scrollController,
          controller: controller.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _carosoleObserver(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      bottom: 2.h,
                      right: 4.w,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Trending",
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
        ));
  }

  Obx _WallpaperObserver() {
    return Obx(
      () {
        if (controller.isCaroSoleLoading.value) {
          return Center(
              child: Container(
            height: 20.0.h,
            width: 80.w,
          ));
        } else if (controller.isCaroSoleDataError.value) {
          return const Center(
            child: Text('Error'),
          );
        } else if (controller.isCaroSoleDataError.value) {
          return const Center(
            child: Text('Error'),
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
                itemCount: controller.wallpaperList.length,
                itemBuilder: (context, index) {
                  if (index == controller.wallpaperList.length - 1 &&
                      controller.isMoreDataAvailable.value == true) {
                    return controller.page < 6
                        ? Center(
                            child: CircularProgressIndicator(
                              color: theme.neoncolor,
                            ),
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
                          print("not initialized");
                        }
                        Get.to(
                          () => ImageView(
                            id: controller.wallpaperList[index]['id'],
                            photographer: controller.wallpaperList[index]
                                    ['photographer']
                                .toString(),
                            photographer_url: controller.wallpaperList[index]
                                    ['photographer_url']
                                .toString(),
                            photographer_id: controller.wallpaperList[index]
                                ['photographer_id'],
                            large2x: controller.wallpaperList[index]['src']
                                    ['portrait']
                                .toString(),
                            large: controller.wallpaperList[index]['src']
                                    ['portrait']
                                .toString(),
                            width: controller.wallpaperList[index]['width']
                                .toString(),
                            height: controller.wallpaperList[index]['height']
                                .toString(),
                            avg_color: controller.wallpaperList[index]
                                    ['avg_color']
                                .toString(),
                          ),
                        );
                      },
                      child: Hero(
                        tag: controller.wallpaperList[index]['id'],
                        child: Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.wallpaperList[index]['src']
                                      ['medium']
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

  Obx _carosoleObserver() {
    return Obx(
      () {
        if (controller.isCaroSoleLoading.value) {
          return CarouselSlider(
              items: generateShimmer(),
              options: CarouselOptions(
                height: 20.h,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                // autoPlayCurve: Curves.fastOutSlowIn,
                // enlargeCenterPage: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                reverse: false,
              ));
        } else if (controller.isCaroSoleDataError.value) {
          return const Center(
            child: Text('Error'),
          );
        } else if (controller.isCaroSoleDataError.value) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return CarouselSlider(
            items: generateSlider(),
            options: CarouselOptions(
              height: 20.h,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              // autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              reverse: false,
            ),
          );
        }
      },
    );
  }

  List<Widget> generateSlider() {
    List<Widget> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(
        WallpaperCard(controller: controller, i: i),
      );
    }
    return list;
  }
}

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
    return CachedNetworkImage(
      imageUrl: controller.carosoleItems[i]['src']['landscape'],
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

List<Widget> generateShimmer() {
  List<Widget> list = [];
  for (var i = 0; i < 10; i++) {
    list.add(
      Shimmer.fromColors(
        baseColor: theme.neoncolor,
        highlightColor: theme.neoncolor.withOpacity(0.10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  return list;
}

AppBar _buildAppbar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset("assets/icons/hamburger.png")),
    title: Text(
      "Wallpix",
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
          HeroIcons.searchCircle,
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
