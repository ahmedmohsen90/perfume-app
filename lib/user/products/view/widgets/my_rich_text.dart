import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/extensions/string.dart';

import '../../../../core/components/sized_box_helper.dart';
import '../../../../core/themes/themes.dart';

class MyRichText extends StatelessWidget {
  const MyRichText({super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return BoxHelper(
      width: 140,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${title.translate}: ',
              style: MainTheme.headerStyle3.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12),
              ),
            ),
            TextSpan(
              text: data,
              style: MainTheme.headerStyle3.copyWith(
                fontSize: ScreenUtil().setSp(12),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
