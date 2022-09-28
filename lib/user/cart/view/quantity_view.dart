import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/loader_widget.dart';

import '../viewModel/cart/cart_cubit.dart';

class QuantityView extends StatelessWidget {
  const QuantityView({
    Key? key,
    this.quantity,
    this.productId,
    this.cartId,
    required this.myCartCubit,
    required this.isWholesaleProduct,
  }) : super(key: key);
  final String? quantity;
  final int? productId;
  final int? cartId;
  final CartCubit myCartCubit;
  final bool isWholesaleProduct;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          current ==
              DeleteCartItemLoading(
                productId: productId ?? 0,
              ) ||
          current is! DeleteCartItemLoading,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Visibility(
                  visible: true, // !isWholesaleProduct,
                  child: InkWell(
                    onTap: () => myCartCubit.updateCartQuantity(
                      context,
                      isMinus: true,
                      productId: productId,
                    ),
                    child: const CartQuantityButton(
                      icons: Icons.remove,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '$quantity',
                  ),
                ),
                // Expanded(
                //   child: RegisterField(
                //     keyboardType: TextInputType.phone,
                //     formatters: [
                //       FilteringTextInputFormatter
                //           .digitsOnly,
                //     ],
                //     removePadding: true,
                //     thinBorder: true,
                //   ),
                //   // flex: 2,
                // ),
                Visibility(
                  visible: true, // !isWholesaleProduct,
                  child: InkWell(
                    onTap: () => myCartCubit.updateCartQuantity(
                      context,
                      isMinus: false,
                      productId: productId,
                    ),
                    child: const CartQuantityButton(
                      icons: Icons.add,
                    ),
                  ),
                ),
              ].reversed.toList(),
            ),
            IconButton(
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              onPressed: () => myCartCubit.deleteItem(
                // context,
                // cartId: cartId,
                productId: productId,
              ),
              icon: state is DeleteCartItemLoading
                  ? const LoaderWidget()
                  : const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
            )
          ],
        );
      },
    );
  }
}

class CartQuantityButton extends StatelessWidget {
  const CartQuantityButton({Key? key, required this.icons}) : super(key: key);
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().radius(2)),
        child: Icon(
          icons,
          color: Colors.white,
        ),
      ),
    );
  }
}
