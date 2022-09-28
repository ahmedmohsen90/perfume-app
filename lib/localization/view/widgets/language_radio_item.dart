import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/sized_box_helper.dart';

class LanguageRadioItem extends StatelessWidget {
  const LanguageRadioItem({
    Key? key,
    required this.flag,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);
  final String flag;
  final String title;
  final String value;
  final String groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                flag,
              ),
              const BoxHelper(
                width: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
