import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/string.dart';
import '../helper/navigator.dart';
import '../themes/screen_utility.dart';
import '../themes/themes.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.verticalPadding = 0,
    this.fontWeight = FontWeight.normal,
    this.textColor,
  });
  final String title;
  final void Function()? onPressed;
  final FontWeight fontWeight;
  final num verticalPadding;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(15),
        right: ScreenUtil().setWidth(15),
        // top: ScreenUtil().setHeight(verticalPadding),
        bottom: ScreenUtil().setHeight(verticalPadding),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Text(
          title,
          style: MainTheme.headerStyle3.copyWith(
            fontWeight: fontWeight,
            // color: textColor,
            color: textColor ?? MainStyle.detailsColor,
          ),
        ),
      ),
    );
  }
}
