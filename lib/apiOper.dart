import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/model.dart';

class ApiOperations{
  static List<PhotosModel> trendingWallpapers =[];
  static List<PhotosModel> searchWallpapersList =[];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<PhotosModel>> getTrendingWallpapers() async {



    await http.get(Uri.parse('https://api.pexels.com/v1/curated'),
        headers: {'Authorization':'tykr03wKQtYOAdw7KSV2CjPIGOWnY9M3cc8fmVP2WLeALQrTHUniwyNz'}).then((value) {

      Map< String, dynamic> jsonData=jsonDecode(value.body);
      List photos=jsonData['photos'];
      photos.forEach((element) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      });

    });
    return trendingWallpapers;

  }
  static Future<List<PhotosModel>> searchWallpapers(String query) async {

    await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=51&page=1'),
        headers: {'Authorization':'tykr03wKQtYOAdw7KSV2CjPIGOWnY9M3cc8fmVP2WLeALQrTHUniwyNz'}).then((value) {

      Map< String, dynamic> jsonData=jsonDecode(value.body);
      List photos=jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {

        searchWallpapersList.add(PhotosModel.fromAPI2App(element));
      });

    });
    return searchWallpapersList;

  }
  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      'Dark',
      'Abstract'
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
      (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}