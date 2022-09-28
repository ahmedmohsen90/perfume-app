import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/not_found_item.dart';
import 'package:perfume/core/components/register_field.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/helper.dart';
import 'package:perfume/core/themes/screen_utility.dart';
import 'package:perfume/core/themes/themes.dart';
import 'package:perfume/user/search/viewModel/searchProducts/search_products_cubit.dart';

import '../../../core/components/home_product_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = '/search-result';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchProductsCubit searchProductsCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    searchProductsCubit = context.read<SearchProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: Column(
        children: [
          RegisterField(
            controller: searchProductsCubit.keywordController,
            hintText: 'search',
            onComplete: () => searchProductsCubit.searchProduct(),
            suffixIcon: IconButton(
              onPressed: () => searchProductsCubit.searchProduct(),
              icon: const Icon(
                Icons.search,
              ),
              iconSize: ScreenUtil().radius(25),
              color: MainStyle.newGreyColor.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchProductsCubit, SearchProductsState>(
              builder: (context, state) {
                if (state is SearchProductsLoading) {
                  return const LoaderWidget();
                }

                if (state is SearchProductsInitial) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/icons/search_helper.jpeg',
                              fit: BoxFit.cover,
                              height: ScreenUtil().setHeight(130),
                              width: ScreenUtil().setWidth(130),
                            ),
                          ),
                          Text(
                            'search_helper'.translate,
                            textAlign: TextAlign.center,
                            style: MainTheme.headerStyle3,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (searchProductsCubit.result.isEmpty) {
                  return const NotFoundItem();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                      child: Text(
                        'Search Results :', //.translate,
                        textAlign: TextAlign.center,
                        style: MainTheme.headerStyle3,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Align(
                          alignment: Helper.appAlignment,
                          child: Wrap(
                            children: List.generate(
                              searchProductsCubit.result.length,
                              (index) {
                                var product = searchProductsCubit.result[index];
                                return ProductItem(
                                  productSlug: product.slug ?? '',
                                  productOldPrice: product.oldPrice,
                                  imagePath: product.images?.first.url,
                                  isFav: product.inWishlist ?? false,
                                  images: product.images!
                                      .map((e) => e.url ?? '')
                                      .toList(),
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
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
