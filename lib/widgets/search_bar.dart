
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
               const   Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                 const  Text(
                    'Search Drive chap',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
