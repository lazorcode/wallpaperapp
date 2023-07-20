import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
            'Wallpapers',
            style: TextStyle(
                color: Colors.black
            ),
          )


    );
  }
}
