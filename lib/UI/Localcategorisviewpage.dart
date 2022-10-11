// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'package:wallpix/UI/SetWallpaper.dart';
import 'package:wallpix/controllers/CategorisController.dart';

import '../controllers/LocalCategoryController.dart';
import '../controllers/LocalHomePageController.dart';
import './../Utility/Constants.dart';

class LocalCategoryViewPage extends GetView<CategorisWallpaperController> {
  String catequery;
  LocalCategoryViewPage({
    required this.catequery,
  });
  LocalCategoryController localHomePageController =
      Get.put(LocalCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text('Categories'),
        ),
        body: CustomScrollView(
          controller: localHomePageController.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: GetBuilder(
                        init: LocalCategoryController(),
                        builder: (controller) {
                          return FutureBuilder(
                            future: DefaultAssetBundle.of(context)
                                .loadString('assets/Json/$catequery.json'),
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
                                            tag: new_data['photos'][index]
                                                ['id'],
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
                ],
              ),
            )
          ],
        ));
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
          return const Center(
            child: Text('Error'),
          );
        } else if (controller.isWallpaperDataError.value) {
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
                itemCount: controller.CategoryWallpaperList.length,
                itemBuilder: (context, index) {
                  if (index == controller.CategoryWallpaperList.length - 1 &&
                      controller.isMoreDataAvailable.value == true) {
                    controller.paginateTask(catequery.toString());

                    return controller.page < 5
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
                        Get.to(
                          () => ImageView(
                            id: controller.CategoryWallpaperList[index]['id'],
                            photographer: controller
                                .CategoryWallpaperList[index]['photographer']
                                .toString(),
                            photographer_url: controller
                                .CategoryWallpaperList[index]
                                    ['photographer_url']
                                .toString(),
                            photographer_id:
                                controller.CategoryWallpaperList[index]
                                    ['photographer_id'],
                            large2x: controller.CategoryWallpaperList[index]
                                    ['src']['portrait']
                                .toString(),
                            large: controller.CategoryWallpaperList[index]
                                    ['src']['portrait']
                                .toString(),
                            width: controller.CategoryWallpaperList[index]
                                    ['width']
                                .toString(),
                            height: controller.CategoryWallpaperList[index]
                                    ['height']
                                .toString(),
                            avg_color: controller.CategoryWallpaperList[index]
                                    ['avg_color']
                                .toString(),
                          ),
                        );
                      },
                      child: Hero(
                        tag: controller.CategoryWallpaperList[index]['id'],
                        child: Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.CategoryWallpaperList[index]
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
