import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/helper/helper.dart';

import '../../user/cart/viewModel/cart/cart_cubit.dart';
import 'loader_widget.dart';

class CartTable extends StatelessWidget {
  const CartTable({
    super.key,
    this.controller,
    this.isCheckout = false,
  });
  final ScrollController? controller;
  final bool isCheckout;

  @override
  Widget build(BuildContext context) {
    var cartCubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is! DeleteCartItemLoading,
      builder: (context, state) {
        return Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          interactive: true,
          radius: const Radius.circular(25),
          controller: controller ?? cartCubit.scrollController,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
            child: SingleChildScrollView(
              controller: controller ?? cartCubit.scrollController,
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    if (!isCheckout) ...[
                      Helper.buildColumn(
                        title: 'image',
                      ),
                    ],
                    Helper.buildColumn(
                      title: 'name',
                    ),
                    Helper.buildColumn(
                      title: 'qty',
                    ),
                    Helper.buildColumn(
                      title: 'price',
                    ),
                    if (!isCheckout) ...[
                      Helper.buildColumn(
                        title: '',
                      ),
                    ] else ...[
                      Helper.buildColumn(
                        title: 'total',
                      ),
                    ],
                  ],
                  rows: List.generate(
                    cartCubit.cartData?.products?.length ?? 0,
                    (index) {
                      var cartItem = cartCubit.cartData!.products![index];
                      return DataRow(
                        cells: [
                          if (!isCheckout) ...[
                            Helper.buildCell(
                              child: BoxHelper(
                                width: 50,
                                height: 50,
                                child: Container(
                                  width: ScreenUtil().setWidth(50),
                                  height: ScreenUtil().setHeight(50),
                                  margin: EdgeInsets.symmetric(
                                    vertical: ScreenUtil().setHeight(2),
                                  ),
                                  color: Colors.white,
                                  child: Image.network(
                                    cartItem.image ?? '',
                                    width: ScreenUtil().setWidth(50),
                                    height: ScreenUtil().setHeight(50),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          Helper.buildCell(
                            title: cartItem.name,
                          ),
                          Helper.buildCell(
                            title: cartItem.quantity?.toString() ?? '_',
                          ),
                          Helper.buildCell(
                            title: cartItem.price ?? '_',
                          ),
                          if (!isCheckout) ...[
                            Helper.buildCell(
                                child: BlocBuilder<CartCubit, CartState>(
                              buildWhen: (previous, current) =>
                                  (current is DeleteCartItemLoading &&
                                          current ==
                                              DeleteCartItemLoading(
                                                productId: cartItem.id ?? 0,
                                              ) ||
                                      current is! DeleteCartItemLoading),
                              builder: (context, state) {
                                return IconButton(
                                  constraints: const BoxConstraints(),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  onPressed: () => cartCubit.deleteItem(
                                    // context,
                                    // cartId: cartId,
                                    productId: cartItem.id,
                                  ),
                                  icon: state is DeleteCartItemLoading
                                      ? const LoaderWidget(
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                );
                              },
                            )),
                          ] else ...[
                            Helper.buildCell(
                                title:
                                    '${(double.tryParse(cartItem.price ?? '') ?? 0) * (cartItem.quantity ?? 0)}')
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
