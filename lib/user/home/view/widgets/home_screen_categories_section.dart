import 'package:flutter/material.dart';
import 'package:perfume/core/helper/helper.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/categories/view/products_by_category_screen.dart';

import '../../../../core/components/section_header_item.dart';
import '../../../../core/components/sized_box_helper.dart';
import '../../viewModel/home/home_cubit.dart';
import 'sub_category_item.dart';

class HomeScreenCategoriesSection extends StatelessWidget {
  const HomeScreenCategoriesSection({
    Key? key,
    required this.homeCubit,
  }) : super(key: key);

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderItem(
          title: 'categories',
          onViewAllPressed: () {},
          showViewAll: false,
        ),
        BoxHelper(
          height: 156,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // physics: const NeverScrollableScrollPhysics(),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              //   childAspectRatio: 1.1,
              // ),
              children: List.generate(
                homeCubit.categories.length,
                (index) {
                  var cat = homeCubit.categories[index];
                  return SubCategoryCard(
                    onPressed: () {
                      NavigationService.push(
                        page: ProductsByCategoryScreen.routeName,
                        arguments: {
                          'category_name': cat.name,
                          'category_slug': cat.slug,
                        },
                      );
                    },
                    categoryName: cat.name,
                    categoryImage: cat.image,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
