import 'package:wallpaper_app/models/wallpaper.dart';

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
