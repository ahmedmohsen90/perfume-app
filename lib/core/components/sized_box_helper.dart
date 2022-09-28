import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxHelper extends StatelessWidget {
  const BoxHelper({
    Key? key,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);
  final double? height, width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? null : ScreenUtil().setHeight(height ?? 0.0),
      width: width == null ? null : ScreenUtil().setWidth(width ?? 0.0),
      child: child,
    );
  }
}
