import 'package:get/get_connect.dart';

import '../Utility/API.dart';

class CaroSoleProvider extends GetConnect {
  Future<List<dynamic>> getCarosoles() async {
    try {
      final response = await get(
          'https://api.pexels.com/v1/search?query=amoled wallpaper black dark&per_page=10',
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
