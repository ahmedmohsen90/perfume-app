import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/helper/helper.dart';
import 'sized_box_helper.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/themes/screen_utility.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget(
      {Key? key,
      required this.values,
      required this.labelText,
      required this.onChanged,
      this.selectedValueIndex,
      this.leadingIcons,
      this.validator,
      this.textAlignment,
      this.removePadding = false,
      this.thinBorder = true,
      this.enabled = true})
      : super(key: key);
  final int? selectedValueIndex;
  final List<String?> values;
  final List<String?>? leadingIcons;
  final String? Function(int?)? validator;
  final void Function(int?)? onChanged;
  final String labelText;
  final bool thinBorder;
  final bool removePadding;
  final bool enabled;
  final Alignment? textAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: DropdownButtonFormField(
        validator: validator,
        isExpanded: true,
        items: List.generate(
          values.length,
          (index) => DropdownMenuItem(
            value: index,
            child: leadingIcons == null
                ? Align(
                    alignment: textAlignment ?? Helper.appAlignment,
                    child: Text(
                      values[index]!,
                      textAlign: TextAlign.start,
                    ),
                  )
                : Row(
                    // textDirection: Helper.appDirection,
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(25),
                        child: Image.network(
                          (leadingIcons![index]!),
                        ),
                      ),
                      const BoxHelper(
                        width: 10,
                      ),
                      Text(
                        values[index]!,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          size: ScreenUtil().radius(35),
          color:
              thinBorder ? MainStyle.lightGreyColor : MainStyle.darkGreyColor,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: labelText.translate,
          labelStyle: TextStyle(
            color:
                thinBorder ? MainStyle.lightGreyColor : MainStyle.darkGreyColor,
          ),
          helperStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                thinBorder ? MainStyle.lightGreyColor : MainStyle.darkGreyColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
            borderSide: BorderSide(
              width: thinBorder ? 1 : 2,
              color: thinBorder
                  ? MainStyle.lightGreyColor
                  : MainStyle.darkGreyColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
            borderSide: BorderSide(
              width: thinBorder ? 1 : 2,
              color: thinBorder
                  ? MainStyle.lightGreyColor
                  : MainStyle.darkGreyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
            borderSide: BorderSide(
              width: thinBorder ? 1 : 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        value: selectedValueIndex,
        onChanged: onChanged,
      ),
    );
  }
}
