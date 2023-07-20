class PhotosModel{

  String imgSrc;
  String PhotoName;

  PhotosModel({
    required this.imgSrc, required this.PhotoName});

  static PhotosModel fromAPI2App(Map < String, dynamic> photoMap){
    return PhotosModel(PhotoName: photoMap['photographer'],imgSrc: (photoMap['src'])['portrait']);
  }
}
class CategoryModel {
  String catName;
  String catImgUrl;

  CategoryModel({required this.catImgUrl, required this.catName});

  static CategoryModel fromApi2App(Map<String, dynamic> category) {
    return CategoryModel(
        catImgUrl: category["imgUrl"], catName: category["CategoryName"]);
  }
}