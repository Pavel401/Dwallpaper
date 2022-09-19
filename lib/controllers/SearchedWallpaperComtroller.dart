import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpix/controllers/SearchController.dart';
import 'package:wallpix/providers/SearchProvider.dart';

class SearchedWallpaperController extends GetxController {
  // ignore: non_constant_identifier_names
  final SearchController Searchcontroller =
      Get.put(SearchController(), permanent: false);
  var page = 1;
  var isDataProcessing = false.obs;
  // ignore: non_constant_identifier_names
  ScrollController SearchscrollController = ScrollController();

  var isMoreDataAvailable = true.obs;

  // ignore: non_constant_identifier_names
  var SearchedwallpaperList = List<dynamic>.empty(growable: true).obs;

  var isWallpaperLoading = true.obs;

  var isWallpaperDataError = false.obs;
  void paginateTask(String query) {
    SearchscrollController.addListener(() {
      if (SearchscrollController.position.pixels ==
          SearchscrollController.position.maxScrollExtent) {
        // print("reached end");
        if (page < 5) {
          page++;
          Moregetwalls(page, query);
        }
      }
    });
  }

  void getwalls(String query) {
    try {
      isWallpaperLoading(true);
      SearchWallpaperProvider().getSearchedWallpaper(query).then((value) {
        SearchedwallpaperList.clear();

        isWallpaperLoading(false);

        SearchedwallpaperList.addAll(value);

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

  void Moregetwalls(int page, String query) {
    try {
      //  print(page);
      isDataProcessing(true);
      SearchWallpaperProvider().loadMoreSearchedWallpaper(page, query).then(
          (value) {
        isDataProcessing(false);
        if (value.length == 0) {
          isMoreDataAvailable(false);
        } else {
          SearchedwallpaperList.addAll(value);
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
    String query = "amoled wallpaper black dark";
    getwalls(query);

    paginateTask(Searchcontroller.searchController.text);
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
