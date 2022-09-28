import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/themes/screen_utility.dart';

import '../../../../core/components/sized_box_helper.dart';
import '../../viewModel/viewProduct/view_product_cubit.dart';
import 'my_rich_text.dart';

class ProductInformationCard extends StatelessWidget {
  const ProductInformationCard({
    Key? key,
    required this.viewProductCubit,
  }) : super(key: key);

  final ViewProductCubit viewProductCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
        vertical: ScreenUtil().setHeight(10),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
        vertical: ScreenUtil().setHeight(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyRichText(
                title: 'availability',
                data: (viewProductCubit.productData?.inStock == true
                        ? 'in_stock'
                        : 'not_in_stock')
                    .translate,
              ),
              MyRichText(
                title: 'sku',
                data: viewProductCubit.productData?.skuCode ?? '',
              ),
            ],
          ),
          const BoxHelper(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyRichText(
                title: 'tax_info',
                data: viewProductCubit.productData?.taxInfo ?? '',
              ),
              MyRichText(
                title: 'seller',
                data: viewProductCubit.productData?.seller ?? '',
              ),
            ],
          ),
          const BoxHelper(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyRichText(
                title: 'category',
                data: viewProductCubit.productData?.category ?? '',
              ),
              MyRichText(
                title: 'barcode',
                data: viewProductCubit.productData?.barcode ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
