// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallpix/controllers/SearchController.dart';
import 'package:wallpix/providers/Categoryprovider.dart';
import 'package:wallpix/providers/SearchProvider.dart';

class CategorisWallpaperController extends GetxController {
  // ignore: non_constant_identifier_names
  final SearchController Searchcontroller =
      Get.put(SearchController(), permanent: false);
  var page = 1;

  var CategoryQuery = "hand".obs;
  var isDataProcessing = false.obs;
  // ignore: non_constant_identifier_names
  ScrollController CategorisScrollController = ScrollController();

  var isMoreDataAvailable = true.obs;

  // ignore: non_constant_identifier_names
  var CategoryWallpaperList = List<dynamic>.empty(growable: true).obs;

  var isWallpaperLoading = true.obs;

  var isWallpaperDataError = false.obs;
  void paginateTask(String query) {
    CategorisScrollController.addListener(() {
      if (CategorisScrollController.position.pixels ==
          CategorisScrollController.position.maxScrollExtent) {
        print("reached end");

        if (page < 5) {
          print(page);
          page++;
          Moregetwalls(page, query);
        }
      }
    });
  }

  void getwalls(String query) {
    try {
      isWallpaperLoading(true);
      CategoryWallpaperProvider().getCategoryWallpaper(query).then((value) {
        CategoryWallpaperList.clear();

        isWallpaperLoading(false);

        CategoryWallpaperList.addAll(value);

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
  void Moregetwalls(int page, String query) {
    try {
      isDataProcessing(true);
      CategoryWallpaperProvider().loadMoreCategoryWallpaper(page, query).then(
          (value) {
        isDataProcessing(false);
        if (value.length == 0) {
          isMoreDataAvailable(false);
        } else {
          CategoryWallpaperList.addAll(value);
        }
      }, onError: (err) {
        isDataProcessing(false);
      });
      // ignore: empty_catches

    } catch (e) {
      isDataProcessing(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    //String query = "amoled";
    //getwalls(CategoryQuery.toString());
    // print("Inside Init " + CategoryQuery.toString());

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

  @override
  String toString() {
    return 'CategorisWallpaperController(page: $page, CategoryQuery: $CategoryQuery, isDataProcessing: $isDataProcessing, isMoreDataAvailable: $isMoreDataAvailable, CategoryWallpaperList: $CategoryWallpaperList, isWallpaperLoading: $isWallpaperLoading, isWallpaperDataError: $isWallpaperDataError)';
  }
}
