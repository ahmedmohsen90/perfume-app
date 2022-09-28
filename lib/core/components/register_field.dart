import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/extensions/string.dart';

import '../themes/screen_utility.dart';

class RegisterField extends StatelessWidget {
  const RegisterField({
    Key? key,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.keyboardType,
    this.obsecureText = false,
    this.thinBorder = true,
    this.controller,
    this.contentPadding,
    this.validator,
    this.autovalidateMode,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.formatters,
    this.prefixIcon,
    this.hideBorder = false,
    this.removePadding = false,
    this.textInputAction,
    this.prefixWithDivider = false,
    this.enabled = true,
    this.makeContentPadding = false,
    this.onTap,
    this.noLocalHintText,
    this.noLocalLabelText,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.hintTextSize,
    this.hintFontWeight,
    this.onFieldSubmitted,
    this.onComplete,
  }) : super(key: key);
  final String? labelText;
  final String? hintText;
  final String? noLocalHintText;
  final String? noLocalLabelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool prefixWithDivider;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final bool thinBorder;
  final bool enabled;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? maxLength;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool removePadding;
  final bool hideBorder;
  final TextInputAction? textInputAction;
  final bool makeContentPadding;
  final void Function()? onTap;
  final void Function()? onComplete;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final num? hintTextSize;
  final FontWeight? hintFontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // height: MediaQuery.of(context).size.height * 0.12,
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        style: TextStyle(
          fontSize: ScreenUtil().setSp(14),
        ),
        // textAlignVertical: TextAlignVertical.top,
        textAlign: textAlign,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onComplete,
        onTap: onTap,

        readOnly: !enabled,
        textInputAction: textInputAction,
        maxLength: maxLength,
        maxLines: maxLines,
        inputFormatters:
            formatters != null && keyboardType == TextInputType.phone
                ? [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9٠-٩]'),
                    ),
                  ]
                : formatters,
        onChanged: onChanged,
        autovalidateMode: autovalidateMode,
        controller: controller,
        validator: validator,
        obscureText: obsecureText,
        keyboardType: keyboardType,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: makeContentPadding
              ? const EdgeInsets.symmetric(vertical: 25, horizontal: 20)
              : contentPadding,
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          labelText: noLocalLabelText ?? labelText?.translate,
          hintText: noLocalHintText ?? hintText?.translate,
          // hintMaxLines: 1,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: thinBorder
                ? MainStyle.newGreyColor.withOpacity(0.6)
                : MainStyle.darkGreyColor,
          ),
          hintStyle: TextStyle(
            fontWeight: hintFontWeight,
            fontSize: hintTextSize?.toDouble(),
            color: thinBorder
                ? MainStyle.newGreyColor.withOpacity(0.6)
                : MainStyle.darkGreyColor,
          ),
          border: hideBorder
              ? null
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
                  borderSide: BorderSide(
                    width: thinBorder ? 1 : 2,
                    color: thinBorder
                        ? MainStyle.lightGreyColor
                        : MainStyle.darkGreyColor,
                  ),
                ),
          enabledBorder: hideBorder
              ? null
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
                  borderSide: BorderSide(
                    width: thinBorder ? 1 : 2,
                    color: thinBorder
                        ? MainStyle.lightGreyColor
                        : MainStyle.darkGreyColor,
                  ),
                ),
          focusedBorder: hideBorder
              ? null
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
                  borderSide: BorderSide(
                    width: thinBorder ? 1 : 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon != null && prefixWithDivider
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                    bottom:
                        (maxLines ?? 0) > 1 ? ScreenUtil().setHeight(65) : 0,
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: prefixIcon,
                      ),
                      Container(
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setHeight(30),
                        color: Theme.of(context).textTheme.headline2?.color,
                      ),
                    ],
                  ),
                )
              : ((maxLines ?? 0) > 1 && prefixWithDivider)
                  ? null
                  : prefixIcon,
          // prefix: prefixIcon != null && prefixWithDivider && (maxLines ?? 0) > 1
          //     ? Padding(
          //         padding: EdgeInsets.only(
          //           right: Helper.currentLanguage == 'en' ? 5 : 0,
          //           left: Helper.currentLanguage == 'ar' ? 5 : 0,
          //         ),
          //         child: Row(
          //           // crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10),
          //               child: prefixIcon,
          //             ),
          //             Container(
          //               width: ScreenUtil().setWidth(1),
          //               height: ScreenUtil().setHeight(30),
          //               color: Theme.of(context).textTheme.headline2?.color,
          //             ),
          //           ],
          //         ),
          //       )
          //     : null,
        ),
      ),
    );
  }
}
