import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({
    super.key,
    required this.icon,
    required this.titleAddress,
    required this.descriptionsAddress,
  });
  final IconData icon;
  final String titleAddress;
  final String descriptionsAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleAddress,
              style: const TextStyle(
                  fontFamily: 'Bolt Semibold',
                  color: Colors.black,
                  fontSize: 15),
            ),
            Text(
              descriptionsAddress,
              style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
