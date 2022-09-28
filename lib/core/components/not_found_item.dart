import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/extensions/string.dart';

import '../themes/themes.dart';
import 'sized_box_helper.dart';

class NotFoundItem extends StatelessWidget {
  const NotFoundItem({
    Key? key,
    this.message,
  }) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
        vertical: ScreenUtil().setHeight(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/oops.png',
            width: ScreenUtil().setWidth(155),
            color: Theme.of(context).primaryColor,
          ),
          const BoxHelper(
            height: 50,
          ),
          Text(
            message ?? 'not_found'.translate,
            textAlign: TextAlign.center,
            style: MainTheme.headerStyle3,
          ),
        ],
      ),
    );
  }
}
