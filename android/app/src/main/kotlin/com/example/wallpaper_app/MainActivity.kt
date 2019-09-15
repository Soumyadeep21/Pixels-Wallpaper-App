package com.example.wallpaper_app

import android.app.WallpaperManager
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File
import java.io.IOException
import java.nio.channels.Channel

class MainActivity: FlutterActivity() {
  private  val CHANNEL = "wallpaper"
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView,CHANNEL).setMethodCallHandler{call, result ->
        val path : String = (call.arguments).toString()
        when(call.method){
            "HomeScreen" -> result.success(setWallpaper(path,1))
            "LockScreen" -> result.success(setWallpaper(path, 2))
            "Both" -> result.success(setWallpaper(path,3))
            else -> result.notImplemented()
        }
    }
  }
   private fun setWallpaper(path:String?,type:Int):String{
        try {
            if(path == null)
                return "Some Error Happened !"
            val imgFile = File(path)
            val res: String
            val bitmap = BitmapFactory.decodeFile(imgFile.absolutePath)
            val wallpaperManager = WallpaperManager.getInstance(this)
            when (type) {
                1 -> res = try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
                        "Home Screen set successfully"
                    } else
                        "To set Wallpaper Android Nougat or higher required !"
                }catch (e:IOException){
                    "Error!"
                }
                2 -> res = try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                        "Lock Screen set successfully"
                    } else
                        "To set Wallpaper Android Nougat or higher required !"
                }catch (e:IOException){
                    "Error!"
                }
                3 -> res = try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        wallpaperManager.setBitmap(bitmap, null, true)
                        "Both Home and Lock Screen set successfully"
                    } else
                        "To set Wallpaper Android Nougat or higher required !"
                }catch (e:IOException){
                    "Error!"
                }
                else -> res = "No Option Available"
            }
            return  res
        }catch(e:IOException){
            return "Some Error Happened !"
        }

    }
}
