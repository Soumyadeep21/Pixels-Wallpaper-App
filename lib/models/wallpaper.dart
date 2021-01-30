class Wallpaper{

  String largeImageURL;
  String previewImageURL;
  String webFormatURL;
  String id;
  int imageSize;
  String pageURL;
  int imageWidth;
  int imageHeight;

  Wallpaper.fromJSON(Map<String,dynamic> json){
  largeImageURL = json['largeImageURL'];
  previewImageURL = json['previewURL'];
  webFormatURL = json['webformatURL'];
  imageSize = json['imageSize'];
  pageURL = json['pageURL'];
  imageWidth = json['imageWidth'];
  imageHeight = json['imageHeight'];
  id = json['id'].toString();
}
}