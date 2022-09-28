import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/helper.dart';
import '../themes/screen_utility.dart';
import '../themes/themes.dart';

class CustomizedExpansionTile extends StatelessWidget {
  const CustomizedExpansionTile({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        // controlAffinity: ListTileControlAffinity.platform,
        // tilePadding: EdgeInsets.zero,
        iconColor: Theme.of(context).primaryColor,
        title: Text(
          title,
          style: MainTheme.headerStyle3.copyWith(
            fontWeight: FontWeight.normal,
            color: MainStyle.detailsColor,
          ),
        ),
        expandedAlignment: Helper.appAlignment,
        childrenPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(4),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
