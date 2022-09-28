import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/cart_table.dart';
import 'package:perfume/core/components/register_button.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/helper.dart';

import '../../user/addresses/view/addresses_screen.dart';
import '../../user/cart/viewModel/cart/cart_cubit.dart';
import '../helper/navigator.dart';
import '../themes/themes.dart';
import 'loader_widget.dart';
import 'sized_box_helper.dart';

class CartView extends StatelessWidget {
  const CartView({
    super.key,
    this.isCheckout = false,
    this.controller,
  });
  final bool isCheckout;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is! DeleteCartItemLoading,
      builder: (context, state) {
        var cartCubit = context.read<CartCubit>();
        return Column(
          children: [
            const CartTable(),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Column(
                children: [
                  const BoxHelper(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'total'.translate,
                        style: MainTheme.headerStyle3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${cartCubit.cartData?.total?.toStringAsFixed(2) ?? ''} ${'kd'.translate}',
                        style: MainTheme.headerStyle3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  Visibility(
                    visible: !isCheckout,
                    child: RegisterButton(
                      color: Colors.white,
                      removeElevation: true,
                      removePadding: true,
                      radius: 10,
                      onPressed: cartCubit.cartData?.products?.isEmpty == true
                          ? null
                          : () {
                              NavigationService.push(
                                page: MyAddressesScreen.routeName,
                                preventDuplicates: false,
                              );
                            },
                      title: 'checkout',
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
