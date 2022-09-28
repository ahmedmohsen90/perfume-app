import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/localization/view/widgets/language_radio_item.dart';
import 'package:perfume/localization/viewModel/lang/lang_cubit.dart';

class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({
    Key? key,
    required this.langCubit,
  }) : super(key: key);

  final LangCubit langCubit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'lang'.translate,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ...List.generate(langCubit.langs.length, (index) {
              var langItem = langCubit.langs[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LanguageRadioItem(
                    flag: langItem.flag,
                    value: langItem.code,
                    groupValue: langCubit.currentLanguage,
                    onChanged: (v) => langCubit.chooseLanguage(
                      code: v,
                      context: context,
                    ),
                    title: langItem.language,
                  ),
                  Visibility(
                    visible: langItem != langCubit.langs.last,
                    child: const BoxHelper(
                      height: 10,
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
