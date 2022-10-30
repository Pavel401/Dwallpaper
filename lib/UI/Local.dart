// ignore: file_names
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wallpix/UI/SearchPage.dart';
import 'package:wallpix/UI/SetWallpaper.dart';
import 'package:wallpix/UI/Widgets/WallpaperCard.dart';
import 'package:wallpix/UI/Widgets/drawer.dart';
import 'package:wallpix/Utility/Constants.dart';
import 'package:wallpix/controllers/DrawerController.dart';
import 'package:wallpix/controllers/LocalHomePageController.dart';
import 'package:wallpix/controllers/carosoleController.dart';
import 'package:sizer/sizer.dart';

import 'Widgets/CarosoleWidget.dart';

// ignore: must_be_immutable
class local extends GetView<Controllers> {
  local({super.key});
  SidebarController drawerController = Get.put(SidebarController());
  LocalHomePageController localHomePageController =
      Get.put(LocalHomePageController());
  @override
  Widget build(BuildContext context) {
    // print("widget initialized");
    Get.lazyPut(() => Controllers());
    return Scaffold(
        key: drawerController.scaffoldKey,
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              drawerController.openDrawer();
            },
            child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/icons/hamburger.png")),
          ),
          title: Text(
            "Dwallpaper",
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
        ),
        drawer: sidebar(),
        body: CustomScrollView(
          // controller: Controllers.scrollController,
          controller: localHomePageController.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/Json/Carosole.json'),
                    builder: ((context, snapshot) {
                      var new_data = json.decode(snapshot.data.toString());

                      if (snapshot.hasData) {
                        return CarouselSlider(
                          items: generateSlider(new_data),
                          options: CarouselOptions(
                            height: 20.h,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            // autoPlayCurve: Curves.fastOutSlowIn,
                            // enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                          ),
                        );
                      } else {
                        return CarouselSlider(
                            items: generateShimmer(),
                            options: CarouselOptions(
                              height: 20.h,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              // autoPlayCurve: Curves.fastOutSlowIn,
                              // enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              reverse: false,
                            ));
                      }
                    }),
                  ),
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
                  Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: GetBuilder(
                        init: LocalHomePageController(),
                        builder: (controller) {
                          return FutureBuilder(
                            future: DefaultAssetBundle.of(context)
                                .loadString('assets/Json/amoled.json'),
                            builder: (context, snapshot) {
                              var new_data =
                                  json.decode(snapshot.data.toString());
                              // print(new_data.toString());

                              if (snapshot.hasData) {
                                return AlignedGridView.count(
                                    addAutomaticKeepAlives: false,
                                    physics: const PageScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 12,
                                    itemCount: localHomePageController.max,
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          localHomePageController.max - 1) {
                                        return localHomePageController.max < 160
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: theme.neoncolor,
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  "More Wallpapers Coming Soon",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              );
                                      } else {
                                        return InkWell(
                                          onTap: () async {
                                            var isInitialized =
                                                await Appodeal.show(
                                                    Appodeal.INTERSTITIAL);

                                            if (isInitialized) {
                                              Appodeal.show(
                                                  Appodeal.INTERSTITIAL);
                                            } else {
                                              //   print("not initialized");
                                            }
                                            Get.to(
                                              () => ImageView(
                                                id: new_data['photos'][index]
                                                    ['id'],
                                                photographer: new_data['photos']
                                                        [index]['photographer']
                                                    .toString(),
                                                photographer_url:
                                                    new_data['photos'][index]
                                                            ['photographer_url']
                                                        .toString(),
                                                photographer_id:
                                                    new_data['photos'][index]
                                                        ['photographer_id'],
                                                large2x: new_data['photos']
                                                            [index]['src']
                                                        ['portrait']
                                                    .toString(),
                                                large: new_data['photos'][index]
                                                        ['src']['portrait']
                                                    .toString(),
                                                width: new_data['photos'][index]
                                                        ['width']
                                                    .toString(),
                                                height: new_data['photos']
                                                        [index]['height']
                                                    .toString(),
                                                avg_color: new_data['photos']
                                                        [index]['avg_color']
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            transitionOnUserGestures: true,
                                            tag: new_data['photos'][index],
                                            child: Container(
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: new_data['photos']
                                                              [index]['src']
                                                          ['medium']
                                                      .toString(),
                                                  placeholder: (context, url) {
                                                    return Center(
                                                      child: Container(
                                                        height: 30.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: theme
                                                                  .neoncolor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                theme.neoncolor,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    });
                              } else {
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Shimmer.fromColors(
                                            baseColor: HexColor("#C9F560"),
                                            highlightColor: HexColor("#C9F560")
                                                .withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )
          ],
        ));
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
          return Container();
        }
      },
    );
  }

  List<Widget> generateSlider(var new_data) {
    List<Widget> list = [];
    for (var i = 0; i < 10; i++) {
      list.add(
        InkWell(
          onTap: () async {
            var isInitialized = await Appodeal.show(Appodeal.INTERSTITIAL);

            if (isInitialized) {
              Appodeal.show(Appodeal.INTERSTITIAL);
            } else {
              //print("not initialized");
            }

            Get.to(
              () => ImageView(
                id: new_data['photos'][i]['id'],
                photographer: new_data['photos'][i]['photographer'].toString(),
                photographer_url:
                    new_data['photos'][i]['photographer_url'].toString(),
                photographer_id: new_data['photos'][i]['photographer_id'],
                large2x: new_data['photos'][i]['src']['portrait'].toString(),
                large: new_data['photos'][i]['src']['portrait'].toString(),
                width: new_data['photos'][i]['width'].toString(),
                height: new_data['photos'][i]['height'].toString(),
                avg_color: new_data['photos'][i]['avg_color'].toString(),
              ),
            );
          },
          child: CachedNetworkImage(
            imageUrl: new_data['photos'][i]['src']['landscape'],
            placeholder: (context, url) {
              return Container(
                height: 20.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.neoncolor,
                    )),
                child: Center(
                  child: CircularProgressIndicator(
                    color: theme.neoncolor,
                  ),
                ),
              );
            },
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
        ),
      );
    }
    return list;
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
