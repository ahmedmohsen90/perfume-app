import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/themes/themes.dart';
import './sized_box_helper.dart';
import '../extensions/string.dart';

class SectionHeaderItem extends StatelessWidget {
  const SectionHeaderItem({
    Key? key,
    required this.title,
    required this.onViewAllPressed,
    required this.showViewAll,
  }) : super(key: key);
  final String title;
  final void Function() onViewAllPressed;
  final bool showViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.translate,
            textAlign: TextAlign.start,
            style: MainTheme.headerStyle3.copyWith(),
          ),
          Visibility(
            visible: showViewAll,
            //     subcategoriesCubit.subCategories.length > 5,
            child: InkWell(
              onTap: onViewAllPressed,
              child: Row(
                children: [
                  Text(
                    'view_all'.translate,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const BoxHelper(
                    width: 14,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: ScreenUtil().radius(15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
