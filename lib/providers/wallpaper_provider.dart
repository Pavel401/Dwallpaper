import 'package:get/get_connect.dart';

import '../Utility/API.dart';

class WallpaperProvider extends GetConnect {
  int pageIndex = 8;
  Future<List<dynamic>> getWallpaper() async {
    try {
      final response = await get(
          'https://api.pexels.com/v1/search?query=amoled wallpaper black dark&per_page=20',
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

  Future<List<dynamic>> loadMoreWallpaper(int page) async {
    try {
      //pageIndex++;
      final response = await get(
          'https://api.pexels.com/v1/search?query=amoled wallpaper black dark&per_page=20&page=$page',
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
