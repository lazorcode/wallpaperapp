import 'package:flutter/material.dart';
import 'package:wallpaperapp/apiOper.dart';
import 'package:wallpaperapp/fullscreen.dart';
import 'package:wallpaperapp/model.dart';
import 'package:wallpaperapp/searchBar.dart';

class SearchScreen  extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading =true;
  late List<PhotosModel> searchReults;

  GetSearchResults()async {
    searchReults=await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading=false;

    });

  }

  @override
  void initState() {
    super.initState();
    GetSearchResults();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wallpaper'),
        ),

        body:isLoading?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Column(
            children: [
              SearchBarScreen(),
              SizedBox(height: 10,),



              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10)
                  ,height: 605,
                  child: GridView.builder(physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 9,
                        mainAxisExtent: 350
                    ), itemCount: searchReults.length,
                    itemBuilder: ((context,index)=>GridTile(
                      child: InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl:searchReults[index].imgSrc,)));
                      },
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
                                searchReults[index].imgSrc,
                              ),
                            )),
                      ),
                    )),
                  )
              )],
          ),
        )
    );
  }
}
