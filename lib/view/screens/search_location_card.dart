import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/add_location.dart';
import '../../widgets/search_bar.dart';

class SearchLocationsCard extends StatelessWidget {
  const SearchLocationsCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hi ,there.",
              style: TextStyle(
                  fontFamily: 'Bolt Semibold',
                  color: Colors.black,
                  fontSize: 18),
            ),
            const Text(
              "Where to?",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 18),
            ),
            const SearchBarWidget(),
            SizedBox(
              height: 10.h,
            ),
            const AddLocation(
              icon: Icons.home,
              titleAddress: "Add Home",
              descriptionsAddress: 'You have your home address',
            ),
            Divider(
              thickness: 4,
              height: 30,
              color: Colors.grey.shade400,
            ),
            const AddLocation(
              icon: Icons.work,
              titleAddress: "Add Work",
              descriptionsAddress: 'You your work address',
            ),
          ],
        ),
      ),
    );
  }
}
