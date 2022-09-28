import 'dart:developer';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/helper.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/core/themes/themes.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';
import 'package:perfume/user/favorites/viewModel/favorites/favorites_cubit.dart';
import 'package:perfume/user/products/view/view_product_screen.dart';

import '../themes/screen_utility.dart';
import 'register_button.dart';
import 'sized_box_helper.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    this.imagePath,
    this.canAddToCart = true,
    this.productId,
    this.productPrice,
    this.productName,
    this.discount,
    this.isFav = false,
    this.serialNumber,
    this.images,
    this.productSlug,
    this.counterWidget,
    required this.productJson,
    required this.productOldPrice,
  }) : super(key: key);
  final String? imagePath;
  final bool canAddToCart;
  final int? productId;
  final String? productPrice;
  final String? productOldPrice;
  final String? productName;
  final String? discount;
  final String? serialNumber;
  final List<String>? images;
  final bool isFav;
  final String? productSlug;
  final Widget? counterWidget;
  final Map<String, dynamic> productJson;
  @override
  Widget build(BuildContext context) {
    var hasDiscount = productOldPrice != '' &&
        productOldPrice != productPrice &&
        productOldPrice != null &&
        productOldPrice != '0';
    log('productPrice $productPrice $productOldPrice');
    var price = double.tryParse(productPrice ?? '') ?? 0;
    var discountPercentage = ((double.tryParse(discount ?? '') ?? 0) / 100);
    var priceAfterDiscount = (price - (price * discountPercentage));
    var isSliderEmpty = images == null || images?.isEmpty == true;

    int selectedIndex = 0;

    return InkWell(
      onTap: productSlug == null
          ? null
          : () {
              NavigationService.push(
                page: ViewProductScreen.routeName,
                arguments: {
                  'product_slug': productSlug,
                },
              );
            },
      child: BoxHelper(
        height: 330,
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          // margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: MainStyle.newLightGreyColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
              // borderRadius: const BorderRadius.only(
              //   bottomLeft: Radius.circular(25),
              //   bottomRight: Radius.circular(25),
              // ),
            ),
            width: ScreenUtil().setWidth(170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              isSliderEmpty
                                  ? (imagePath ?? '')
                                  : images![selectedIndex],
                              width: double.infinity,
                              height: ScreenUtil().setHeight(150),
                              // fit: BoxFit.cover,
                              errorBuilder: (_, obj, stac) {
                                log('obj $obj stac ');
                                return Image.asset(
                                  'assets/images/oil3.jpg',
                                  width: double.infinity,
                                  height: ScreenUtil().setHeight(150),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        isSliderEmpty
                            ? const BoxHelper()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images!.length > 4 ? 4 : images!.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(2),
                                      horizontal: ScreenUtil().setWidth(2),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Card(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                            color: index != selectedIndex
                                                ? MainStyle.newLightGreyColor
                                                : Colors.black,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: ScreenUtil().radius(20),
                                          backgroundImage: NetworkImage(
                                            images![index],
                                          ),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                ),
                // const BoxHelper(
                //   height: 10,
                // ),
                SizedBox(
                  // height: ScreenUtil().setHeight(Helper.isArabic ? 104 : 100),
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            productName ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: MainTheme.headerStyle3.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          BoxHelper(
                            height: !hasDiscount ? 10 : 5,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${hasDiscount ? priceAfterDiscount.toStringAsFixed(2) : (((double.tryParse((productPrice) ?? '') ?? 0))).toStringAsFixed(2)} ${'kd'.translate}',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.black,
                                ),
                              ),
                              Visibility(
                                visible: hasDiscount,
                                child: Text(
                                  '${double.tryParse(productOldPrice ?? '')?.toStringAsFixed(2) ?? '0.0'} ${'kd'.translate}',
                                  style: MainTheme.headerStyle3.copyWith(
                                    decoration: !hasDiscount
                                        ? null
                                        : TextDecoration.lineThrough,
                                    fontWeight: FontWeight.normal,
                                    color: !hasDiscount
                                        ? Colors.transparent
                                        : Colors.black45,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // const Spacer(),

                          // const BoxHelper(
                          //   height: 5,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: canAddToCart,
                  child: const BoxHelper(
                    height: 10,
                  ),
                ),
                !canAddToCart
                    ? (counterWidget ?? const BoxHelper())
                    : Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const BoxHelper(
                            //   width: 6.5,
                            // ),
                            BlocBuilder<CartCubit, CartState>(
                              buildWhen: (previous, current) =>
                                  current ==
                                      AddToCartLoading(
                                          productId: productId ?? 0) ||
                                  current is! AddToCartLoading,
                              builder: (context, state) {
                                if (state is AddToCartLoading) {
                                  return const LoaderWidget(
                                    color: Colors.black,
                                  );
                                }
                                return SizedBox(
                                  width: ScreenUtil().setWidth(165),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: InkWell(
                                          onTap: productId == null
                                              ? null
                                              : () => context
                                                  .read<CartCubit>()
                                                  .addToCart(
                                                    productId: productId,
                                                  ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  ScreenUtil().setWidth(10),
                                              vertical:
                                                  ScreenUtil().setHeight(10),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Helper.isArabic
                                                      ? Radius.zero
                                                      : const Radius.circular(
                                                          12),
                                                  bottomRight: !Helper.isArabic
                                                      ? Radius.zero
                                                      : const Radius.circular(
                                                          12),
                                                )),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.add_shopping_cart,
                                                  size: ScreenUtil().radius(20),
                                                  color: Colors.white,
                                                ),
                                                const BoxHelper(
                                                  width: 2,
                                                ),
                                                Text(
                                                  'add_to_cart'.translate,
                                                  style: MainTheme.buttonStyle
                                                      .copyWith(
                                                    fontSize:
                                                        ScreenUtil().setSp(13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<FavoritesCubit>()
                                              .toggleProduct(
                                                  context: context,
                                                  productId: productId,
                                                  productJson: productJson),
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: ScreenUtil().radius(20),
                                            color: isFav ? Colors.black : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                // return SizedBox(
                                //   // width: ScreenUtil().setWidth(120),
                                //   // height: ScreenUtil().setHeight(32),
                                //   child: Directionality(
                                //     textDirection: TextDirection.rtl,
                                //     child: RegisterButton(
                                //       removePadding: true,
                                //       removeElevation: true,
                                //       icon: const Icon(
                                //         Icons.add_shopping_cart,
                                //         color: Colors.white,
                                //       ),
                                //       radius: 12,
                                //       title: 'add_to_cart',
                                //       onPressed: productId == null
                                //           ? null
                                //           : () => context
                                //               .read<CartCubit>()
                                //               .addToCart(
                                //                 productId: productId,
                                //               ),
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                            // const BoxHelper(
                            //   width: 6.5,
                            // ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
