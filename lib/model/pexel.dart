// wallpaper identity model

class WallpaperModel {
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? photographer_url;
  String? avg_color;
  String? width;
  String? height;

  // access keys map
  SrcModel? src;

  // create name parameter
  WallpaperModel({
    this.src,
    this.photographerUrl,
    this.photographerId,
    this.photographer,
    this.photographer_url,
    this.avg_color,
    this.width,
    this.height,
  });

  // passing json value from API
  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData['src']),
      photographerUrl: jsonData["photographer_url"],
      photographerId: jsonData["photographer_id"],
      photographer: jsonData["photographer"],
      photographer_url: jsonData["photographer_url"],
      avg_color: jsonData["avg_color"],
      width: jsonData["width"],
      height: jsonData["height"],
    );
  }
}

// wallpaper Source Map Model
class SrcModel {
  String original;
  String small;
  String portrait;

  // create name parameter
  SrcModel({
    required this.original,
    required this.small,
    required this.portrait,
  });

  // passing json value from API
  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData["portrait"],
      original: jsonData["original"],
      small: jsonData["small"],
    );
  }
}
