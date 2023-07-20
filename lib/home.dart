import 'package:flutter/material.dart';
import 'package:wallpaperapp/apiOper.dart';
import 'package:wallpaperapp/catBlock.dart';
import 'package:wallpaperapp/fullscreen.dart';
import 'package:wallpaperapp/model.dart';
import 'package:wallpaperapp/searchBar.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool isLoading =true;
  late List <PhotosModel> trendingWallList;
  late List<CategoryModel> CatModList;


  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  GetTrendingWallpapers() async{
    trendingWallList= await ApiOperations.getTrendingWallpapers();
    setState(() {
      isLoading=false;

    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    GetTrendingWallpapers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper'),
      ),

      body:isLoading? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: Column(
          children: [
            SearchBarScreen(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(height: 45,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(scrollDirection: Axis.horizontal,
                    itemCount: CatModList.length,
                    itemBuilder: ((context,index)=>CatBlock(categoryImgSrc: CatModList[index].catImgUrl,
                      categoryName: CatModList[index].catName,))),
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 10)
              ,height: 552,
              child: GridView.builder(physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 9,
                      mainAxisExtent: 350
                  ), itemCount: trendingWallList.length,
                  itemBuilder: ((context,index)=>GridTile(
                    child: InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl:trendingWallList[index].imgSrc,)));
                    },
                      child: Hero(
                        tag:trendingWallList[index].imgSrc ,
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          height: 700,
                          width: 50,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                                height: 700,
                                width: 50,
                                fit: BoxFit.cover,
                              trendingWallList[index].imgSrc,
                          ),
                        )),
                      ),
                    ),
                  )),
            )
            )],
        ),
      )
    );
  }
}
