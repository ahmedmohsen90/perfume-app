import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/badge_widget.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/localization/viewModel/lang/lang_cubit.dart';
import 'package:perfume/user/cart/view/cart_screen.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';
import 'package:perfume/user/favorites/view/favorites_screen.dart';
import 'package:perfume/user/favorites/viewModel/favorites/favorites_cubit.dart';
import 'package:perfume/user/search/view/search_screen.dart';
import 'package:perfume/user/settings/viewModel/settings/settings_cubit.dart';

import 'my_drawer.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    Key? key,
    required this.scaffoldKey,
    required this.body,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    var langCubit = context.read<LangCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      key: scaffoldKey,
      drawer: MyDrawer(
        langCubit: langCubit,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        // elevation: 0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            Visibility(
              visible: Navigator.canPop(context),
              child: IconButton(
                iconSize: ScreenUtil().radius(25),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                color: Colors.white,
                onPressed: () {
                  NavigationService.goBack();
                },
              ),
            ),
            IconButton(
              iconSize: ScreenUtil().radius(25),
              icon: const Icon(
                Icons.menu,
              ),
              color: Colors.white,
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return Visibility(
                  visible:
                      context.read<SettingsCubit>().settingsData?.logo != null,
                  child: Image.network(
                    context.read<SettingsCubit>().settingsData?.logo ?? '',
                    height: ScreenUtil().setHeight(50),
                    width: ScreenUtil().setWidth(50),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: ScreenUtil().radius(25),
            onPressed: () {
              NavigationService.push(
                page: SearchScreen.routeName,
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return IconButton(
                iconSize: ScreenUtil().radius(25),
                color: Colors.white,
                onPressed: () {
                  NavigationService.push(
                    page: FavoritesScreen.routeName,
                  );
                },
                icon: BadgeWidget(
                  count: context.read<FavoritesCubit>().favListCount,
                  child: const Icon(
                    Icons.favorite_border,
                  ),
                ),
              );
            },
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return IconButton(
                iconSize: ScreenUtil().radius(25),
                color: Colors.white,
                onPressed: () {
                  NavigationService.push(
                    page: CartScreen.routeName,
                    preventDuplicates: Navigator.canPop(context),
                  );
                },
                icon: BadgeWidget(
                  count: context.read<CartCubit>().cartCount,
                  child: const Icon(
                    Icons.shopping_basket_outlined,
                  ),
                ),
              );
            },
          ),
          const BoxHelper(
            width: 10,
          ),
        ],
      ),
      body: body,
    );
  }
}
