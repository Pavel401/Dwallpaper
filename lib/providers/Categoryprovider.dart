import 'package:get/get_connect.dart';

import '../Utility/API.dart';

class CategoryWallpaperProvider extends GetConnect {
  int pageIndex = 8;
  Future<List<dynamic>> getCategoryWallpaper(String query) async {
    try {
      final response = await get(
          'https://api.pexels.com/v1/search?query=$query&per_page=10&page=1',
          headers: {'Authorization': APImanager.apiKey});

      if (response.status.hasError) {
        return Future.error(response.statusText.toString());
      } else {
        return response.body['photos'];
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<dynamic>> loadMoreCategoryWallpaper(
      int page, String query) async {
    try {
      //pageIndex++;
      final response = await get(
          'https://api.pexels.com/v1/search?query=$query&per_page=10&page=$page',
          headers: {'Authorization': APImanager.apiKey});

      if (response.status.hasError) {
        return Future.error(response.statusText.toString());
      } else {
        return response.body['photos'];
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
