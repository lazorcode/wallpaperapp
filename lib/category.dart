import 'package:flutter/material.dart';
import 'package:wallpaperapp/apiOper.dart';
import 'package:wallpaperapp/fullscreen.dart';
import 'package:wallpaperapp/model.dart';

class CategoryScreen  extends StatefulWidget {

  String catName;
  String catImgUrl;

  CategoryScreen({super.key, required this.catImgUrl, required this.catName});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading  = true;
  late List<PhotosModel> categoryResults;
  GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wallpaper'),
        ),

        body:isLoading? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        widget.catImgUrl),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black38,
                    ),

                    height: 120,
                    width: MediaQuery.of(context).size.width,

                  ),
                  Positioned(
                    left: 130,
                    top: 30,
                    child: Column(
                      children: [
                        Text('Category',style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.w400,fontSize: 15
                        )),
                        Text(widget.catName,style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25
                        ),)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),




              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10)
                  ,height: 532,
                  child: GridView.builder(physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 9,
                        mainAxisExtent: 350
                    ), itemCount: 31,
                    itemBuilder: ((context,index)=>GridTile(
                      child: InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl:categoryResults[index].imgSrc,)));
                      },
                        child: Hero(
                          tag:categoryResults[index].imgSrc ,
                          child: Container(

                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              height: 500,
                              width: 50,

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  height: 500,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  categoryResults[index].imgSrc,
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
