import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

class CustomDivider extends StatelessWidget {
  final double height;

  const CustomDivider({Key? key, this.height = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: ColorName.textFieldBackgroundGrey,
    );
  }
}
