class WallpaperResponse{
  
  int totalHits;
  List<Wallpaper> hits;

  WallpaperResponse({this.totalHits, this.hits});

  factory WallpaperResponse.fromJSON(Map<String,dynamic> json){
    int _totalHits = json['totalHits'];
    List<Wallpaper> _hits = <Wallpaper>[];
    if(json['hits']!=null)
    
    json['hits'].forEach((res){
      _hits.add(Wallpaper.fromJSON(res));
    });
    return WallpaperResponse(totalHits: _totalHits,hits: _hits);
  }
}

class Wallpaper{

  String largeImageURL;
  String id;
  int imageSize;
  String pageURL;
  int imageWidth;
  int imageHeight;

  Wallpaper.fromJSON(Map<String,dynamic> json){
  largeImageURL = json['largeImageURL'];
  imageSize = json['imageSize'];
  pageURL = json['pageURL'];
  imageWidth = json['imageWidth'];
  imageHeight = json['imageHeight'];
  id = json['id'].toString();
}
}