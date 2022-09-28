import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/home_product_item.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/loading_more_view.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/themes/themes.dart';
import '../viewModel/favorites/favorites_cubit.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
  });
  static const routeName = '/fav-screen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesCubit favoritesCubit;

  @override
  void initState() {
    favoritesCubit = context.read<FavoritesCubit>()
      ..getFavList();

    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const LoaderWidget();
          }
          if (favoritesCubit.favProducts.isEmpty) {
            return Center(
              child: Text(
                'favorites_empty'.translate,
                style: MainTheme.headerStyle3,
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(5),
                ),
                child: Text(
                  'favorites'.translate,
                  textAlign: TextAlign.center,
                  style: MainTheme.headerStyle3.copyWith(
                    fontSize: ScreenUtil().setSp(17),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(
                      favoritesCubit.favProducts.length,
                      (index) {
                        var product = favoritesCubit.favProducts[index];
                        return ProductItem(
                          productSlug: product.slug ?? '',
                          productOldPrice: product.oldPrice,
                          imagePath: product.images?.first.url,
                          isFav: product.inWishlist ?? false,
                          images:
                              product.images!.map((e) => e.url ?? '').toList(),
                          productId: product.id,
                          productName: product.name,
                          productPrice: product.newPrice,
                          productJson: product.toJson(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: state is FavoritesLoadingMore,
                child: const LoadingMoreView(),
              ),
            ],
          );
        },
      ),
    );
  }
}
