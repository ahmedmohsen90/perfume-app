import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/extensions/media_query.dart';
import 'package:perfume/core/extensions/string.dart';
import '../themes/themes.dart';
import 'sized_box_helper.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    this.title,
    required this.onPressed,
    this.removePadding = false,
    this.icon,
    this.color,
    this.radius = 30,
    this.textSize,
    this.removeElevation = false,
    this.noLocalTitle,
    this.isDeleteButton = false,
    this.fontWeight,
    this.borderColor,
  }) : super(key: key);
  final String? title;
  final void Function()? onPressed;
  final bool removePadding, removeElevation;
  final Widget? icon;
  final Color? color, borderColor;
  final double radius;
  final String? noLocalTitle;
  final num? textSize;
  final bool isDeleteButton;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: context.width,
        height: ScreenUtil().setHeight(50),
        child: ElevatedButton.icon(
          icon: icon ?? const BoxHelper(),
          label: FittedBox(
            child: Text(
              noLocalTitle ?? title?.translate.toTitleCase ?? '',
              style: color == Colors.white
                  ? MainTheme.buttonStyle.copyWith(
                      fontWeight: fontWeight,
                      color: isDeleteButton ? Colors.red : Colors.black,
                      fontSize: textSize == null
                          ? null
                          : ScreenUtil().setSp(textSize!),
                    )
                  : MainTheme.buttonStyle.copyWith(
                      fontWeight: fontWeight,
                      fontSize: textSize == null
                          ? null
                          : ScreenUtil().setSp(textSize!)),
            ),
          ),
          style: ButtonStyle(
            elevation: !removeElevation ? null : MaterialStateProperty.all(0),
            side: MaterialStateProperty.all(
              BorderSide(
                color:
                    borderColor ?? (isDeleteButton ? Colors.red : Colors.black),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              color ?? Colors.black,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
