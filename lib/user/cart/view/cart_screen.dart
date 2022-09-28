import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';

import '../../../core/components/cart_view.dart';
import '../../../core/components/sized_box_helper.dart';
import '../../../core/themes/screen_utility.dart';
import '../../../core/themes/themes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const routeName = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartCubit cartCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    cartCubit = context.read<CartCubit>()..getMyCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) => current is! DeleteCartItemLoading,
        builder: (context, state) {
          if (state is CartLoading) {
            return const LoaderWidget();
          }
          if (cartCubit.cartData == null ||
              cartCubit.cartData?.products?.isEmpty == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'cart_empty'.translate,
                    style: MainTheme.headerStyle3.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => NavigationService.goBack(),
                    child: Text(
                      'continue_shopping'.translate,
                      style: MainTheme.headerStyle3.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const CartView();
        },
      ),
    );
  }
}
