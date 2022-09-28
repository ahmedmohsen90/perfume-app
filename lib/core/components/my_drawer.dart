import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/helper/navigator.dart';

import '../../localization/viewModel/lang/lang_cubit.dart';
import '../helper/helper.dart';
import 'package:perfume/core/components/text_button_widget.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/user/categories/viewModel/catgories/categories_cubit.dart';

import 'package:perfume/user/home/view/home_screen.dart';
import 'package:perfume/user/settings/view/about_us_screen.dart';
import 'package:perfume/user/settings/view/contact_us_screen.dart';
import '../../user/categories/view/products_by_category_screen.dart';
import '../extensions/string.dart';
import 'customized_expansion_tile_item.dart';
import 'sized_box_helper.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.langCubit,
  }) : super(key: key);

  final LangCubit langCubit;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButtonWidget(
            title: 'close'.translate,
            fontWeight: FontWeight.bold,
            onPressed: () {
              NavigationService.goBack();
            },
          ),
          const BoxHelper(
            height: 20,
          ),
          TextButtonWidget(
            title: 'home'.translate,
            onPressed: () async {
              await NavigationService.goBack();
              NavigationService.push(
                page: HomeScreen.routeName,
              );
            },
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const LoaderWidget(color: Colors.black,);
              }
              return CustomizedExpansionTile(
                title: 'categories'.translate,
                children: context
                    .read<CategoriesCubit>()
                    .categories
                    .map(
                      (cat) => TextButtonWidget(
                        title: cat.name ?? '',
                        onPressed: () async {
                          await NavigationService.goBack();
                          NavigationService.push(
                            page: ProductsByCategoryScreen.routeName,
                            arguments: {
                              'category_name': cat.name,
                              'category_slug': cat.slug,
                            },
                          );
                        },
                        verticalPadding: 10,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          TextButtonWidget(
            title: 'contact_us'.translate,
            onPressed: () {
              NavigationService.goBack();
              NavigationService.push(
                page: ContactUsScreen.routeName,
              );
            },
          ),
          const BoxHelper(
            height: 17,
          ),
          TextButtonWidget(
            title: 'about_us'.translate,
            onPressed: () {
              NavigationService.goBack();
              NavigationService.push(page: AboutUsScreen.routeName);
            },
          ),
          const BoxHelper(
            height: 14,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
            ),
            child: const Divider(
              thickness: 1,
            ),
          ),
          BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              return CustomizedExpansionTile(
                title: Helper.isArabic ? 'العربية' : 'English',
                children: langCubit.langs
                    .map(
                      (e) => TextButtonWidget(
                        title: e.language,
                        onPressed: () => langCubit.chooseLanguage(
                          context: context,
                          code: e.code,
                        ),
                        textColor: e.code == Helper.currentLanguage
                            ? Theme.of(context).primaryColor
                            : null,
                        verticalPadding: 10,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    ));
  }
}
