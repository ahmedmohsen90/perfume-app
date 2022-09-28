import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/section_header_item.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/helper/helper.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';
import 'package:perfume/user/categories/viewModel/catgories/categories_cubit.dart';
import 'package:perfume/user/favorites/viewModel/favorites/favorites_cubit.dart';
import 'package:perfume/user/home/model/carousel_widget.dart';
import 'package:perfume/user/home/view/widgets/home_screen_best_sellers_section.dart';
import 'package:perfume/user/home/view/widgets/home_screen_suggested_section.dart';
import 'package:perfume/user/home/view/widgets/sub_category_item.dart';
import 'package:perfume/user/home/viewModel/home/home_cubit.dart';
import 'package:perfume/user/settings/viewModel/settings/settings_cubit.dart';
import 'package:perfume/user/token/viewModel/generateUniqueToken/generate_unique_token_cubit.dart';

import '../../../core/components/scaffold_widget.dart';
import 'widgets/home_screen_categories_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit homeCubit;
  late CategoriesCubit categoriesCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    categoriesCubit = context.read<CategoriesCubit>()..getCategories();
    homeCubit = context.read<HomeCubit>()
      ..getHome(
        context: context,
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('lang ${Helper.currentLanguage}');
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const LoaderWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselWidget(images: homeCubit.sliders),
                const BoxHelper(
                  height: 10,
                ),
                HomeScreenCategoriesSection(
                  homeCubit: homeCubit,
                ),
                HomeScreenSuggestedSection(
                  homeCubit: homeCubit,
                ),
                HomeScreenBestSellersSection(
                  homeCubit: homeCubit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
