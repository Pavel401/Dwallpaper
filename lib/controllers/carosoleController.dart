import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpix/providers/wallpaper_provider.dart';

import '../providers/carosole_provider.dart';

class Controllers extends GetxController {
  var page = 1;
  var isDataProcessing = false.obs;
  ScrollController scrollController = ScrollController();

  var isMoreDataAvailable = true.obs;
  var carosoleItems = List<dynamic>.empty(growable: true).obs;

  var wallpaperList = List<dynamic>.empty(growable: true).obs;

  var isCaroSoleLoading = true.obs;

  var isCaroSoleDataError = false.obs;
  var isWallpaperLoading = true.obs;

  var isWallpaperDataError = false.obs;
  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // print("reached end");
        if (page < 6) {
          // print(page);
          page++;
          Moregetwalls(page);
        }
      }
    });
  }

  void getwalls() {
    try {
      isCaroSoleLoading(true);
      WallpaperProvider().getWallpaper().then((value) {
        wallpaperList.clear();

        isWallpaperLoading(false);

        wallpaperList.addAll(value);

        isWallpaperDataError(false);
      }, onError: (err) {
        isWallpaperLoading(false);
        isWallpaperDataError(true);
      });
      // ignore: empty_catches

    } catch (e) {
      isWallpaperLoading(false);
      isWallpaperDataError(true);
    }
  }

  // ignore: non_constant_identifier_names
  void Moregetwalls(int page) {
    try {
      isDataProcessing(true);
      WallpaperProvider().loadMoreWallpaper(page).then((value) {
        isDataProcessing(false);
        if (value.isEmpty) {
          isMoreDataAvailable(false);
        } else {
          wallpaperList.addAll(value);
        }
      }, onError: (err) {
        isDataProcessing(false);
      });
      // ignore: empty_catches

    } catch (e) {
      isDataProcessing(false);
    }
  }

  void getCarosole() {
    try {
      isCaroSoleLoading(true);
      CaroSoleProvider().getCarosoles().then((value) {
        carosoleItems.clear();

        isCaroSoleLoading(false);

        carosoleItems.addAll(value);

        isCaroSoleDataError(false);
      }, onError: (err) {
        isCaroSoleLoading(false);
        isCaroSoleDataError(true);
      });
      // ignore: empty_catches

    } catch (e) {
      isCaroSoleLoading(false);
      isCaroSoleDataError(true);
    }
  }

  @override
  void onInit() {
    getwalls();
    getCarosole();
    paginateTask();

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => super.onStart;
}
