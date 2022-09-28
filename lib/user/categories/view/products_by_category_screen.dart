import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/home_product_item.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/loading_more_view.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/themes/themes.dart';
import 'package:perfume/user/categories/viewModel/productsByCategory/products_by_category_cubit.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  const ProductsByCategoryScreen({
    super.key,
  });
  static const routeName = '/product-by-category';

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  late ProductsByCategoryCubit productsByCategoryCubit;

  @override
  void initState() {
    productsByCategoryCubit = context.read<ProductsByCategoryCubit>()
      ..initScroll()
      ..getProductsByCategory();

    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
        builder: (context, state) {
          if (state is ProductsByCategoryLoading) {
            return const LoaderWidget();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(5),
                ),
                child: Text(
                  productsByCategoryCubit.categoryName,
                  textAlign: TextAlign.center,
                  style: MainTheme.headerStyle3.copyWith(
                    fontSize: ScreenUtil().setSp(17),
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: productsByCategoryCubit.scrollController,
                  child: Wrap(
                    children: List.generate(
                      productsByCategoryCubit.categoryProducts.length,
                      (index) {
                        var product =
                            productsByCategoryCubit.categoryProducts[index];
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
                visible: state is ProductsByCategoryLoadingMore,
                child: const LoadingMoreView(),
              ),
            ],
          );
        },
      ),
    );
  }
}
