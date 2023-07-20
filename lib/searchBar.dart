import 'package:flutter/material.dart';
import 'package:wallpaperapp/search.dart';


class SearchBarScreen extends StatelessWidget {
  SearchBarScreen({super.key});

  TextEditingController _searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.03),
        border: Border.all(color: Colors.black45.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Wallpapers',
                errorBorder : InputBorder.none,
                focusedBorder : InputBorder.none,
                focusedErrorBorder : InputBorder.none,
                disabledBorder : InputBorder.none,
                enabledBorder : InputBorder.none,
                border : InputBorder.none,
              ),
            ),
          ),InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(query:_searchController.text)));
          },
              child: Icon(Icons.search)),

        ],
      ),


    );
  }
}
