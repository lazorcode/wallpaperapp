import 'package:flutter/material.dart';
import 'package:wallpaperapp/category.dart';
class CatBlock extends StatelessWidget {

  String categoryName;
  String categoryImgSrc;
  CatBlock(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                    catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Container(

        margin: EdgeInsets.symmetric(horizontal: 7),

        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  height: 45,
                  width: 100,
                  fit:BoxFit.cover,
                  categoryImgSrc),
            ),

            Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            Positioned(
                left: 30,
                top: 14,

                child: Text(categoryName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}

