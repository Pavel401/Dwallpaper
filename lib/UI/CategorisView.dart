// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:wallpix/UI/SetWallpaper.dart';
import 'package:wallpix/controllers/CategorisController.dart';

import './../Utility/Constants.dart';

class CategoryView extends GetView<CategorisWallpaperController> {
  String catequery;
  CategoryView({
    required this.catequery,
  });
  @override
  Widget build(BuildContext context) {
    controller.CategoryQuery.value = this.catequery;
    Get.lazyPut(() => CategorisWallpaperController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text('Categories'),
        ),
        body: CustomScrollView(
          controller: controller.CategorisScrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
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
        if (controller.isWallpaperLoading.value) {
          return Center(
              child: Container(
            height: 20.0.h,
            width: 80.w,
          ));
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
