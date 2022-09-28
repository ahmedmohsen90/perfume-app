import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/screen_utility.dart';
import '../../../../core/themes/themes.dart';
import '../../../core/components/sized_box_helper.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);
  final String title;
  final String imagePath;
  final void Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: ScreenUtil().setWidth(70),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        // width: ScreenUtil().setWidth(20),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: isSelected ? 2 : 0.5,
            color: isSelected
                ? Theme.of(context).primaryColor
                : MainStyle.darkGreyColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: ScreenUtil().setHeight(90),
              fit: BoxFit.cover,
              // width: 100,
            ),
            const BoxHelper(
              width: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: MainTheme.headerStyle4,
            ),
          ],
        ),
      ),
    );
  }
}
