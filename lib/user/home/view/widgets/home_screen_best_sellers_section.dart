import 'package:flutter/material.dart';
import 'package:perfume/core/components/home_product_item.dart';

import '../../../../core/components/section_header_item.dart';
import '../../../../core/components/sized_box_helper.dart';
import '../../viewModel/home/home_cubit.dart';
import 'sub_category_item.dart';

class HomeScreenBestSellersSection extends StatelessWidget {
  const HomeScreenBestSellersSection({
    Key? key,
    required this.homeCubit,
  }) : super(key: key);

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderItem(
          title: 'best_sellers',
          onViewAllPressed: () {},
          showViewAll: false,
        ),
        Wrap(
          // physics: const NeverScrollableScrollPhysics(),
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   childAspectRatio: 1.1,
          // ),
          children: List.generate(
            homeCubit.bestSellerProducts.length,
            (index) {
              var product = homeCubit.bestSellerProducts[index];
              return ProductItem(
                productSlug: product.slug ?? '',
                imagePath: product.images?.first.url,
                productOldPrice: product.oldPrice,
                isFav: product.inWishlist ?? false,
                images: product.images!.map((e) => e.url ?? '').toList(),
                productId: product.id,
                productName: product.name,
                productPrice: product.newPrice,
                productJson: product.toJson(),
              );
            },
          ),
        ),
      ],
    );
  }
}
