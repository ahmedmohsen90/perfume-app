import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.count,
    required this.child,
  });
  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Badge(
      animationType: BadgeAnimationType.fade,
      badgeContent: Text(
        count.toString(),
        style:
            TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(11.5)),
      ),
      child: child,
    );
  }
}
