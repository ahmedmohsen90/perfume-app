import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/cart_table.dart';
import 'package:perfume/core/components/cart_view.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/register_button.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/core/themes/themes.dart';
import 'package:perfume/user/addresses/view/create_new_address_screen.dart';
import 'package:perfume/user/addresses/viewModel/myAddress/my_address_cubit.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';
import 'package:perfume/user/checkout/view/checkout_screen.dart';
import 'package:perfume/user/checkout/viewModel/checkout/checkout_cubit.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});
  static const routeName = '/addresses-screen';

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  late MyAddressCubit myAddressCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var scrollController = ScrollController();
  late CheckoutCubit checkoutCubit;

  @override
  void initState() {
    checkoutCubit = context.read<CheckoutCubit>();
    myAddressCubit = context.read<MyAddressCubit>()
      ..getAddresses().then((value) {
        if (myAddressCubit.addresses.isNotEmpty) {
          checkoutCubit.getDeliveryPrice(
              addressId: myAddressCubit.addresses.first.id ?? 0);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocConsumer<MyAddressCubit, MyAddressState>(
        listener: (context, state) {
          if (state is RadioButtonChanged) {
            checkoutCubit.getDeliveryPrice(
              addressId:
                  myAddressCubit.addresses[myAddressCubit.selectedAddress].id ??
                      0,
            );
          }
        },
        builder: (context, state) {
          if (state is MyAddressLoading) {
            return const LoaderWidget();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: myAddressCubit.addresses.isEmpty,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(150),
                      ),
                      child: Text(
                        'address_empty'.translate,
                        style: MainTheme.headerStyle3,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: myAddressCubit.addresses.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                          vertical: ScreenUtil().setHeight(10),
                        ),
                        child: Text(
                          'choose_address'.translate,
                          textAlign: TextAlign.start,
                          style: MainTheme.headerStyle3.copyWith(
                              // color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                      Column(
                        children: List.generate(
                          myAddressCubit.addresses.length,
                          (index) {
                            var address = myAddressCubit.addresses[index];
                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10),
                                vertical: ScreenUtil().setHeight(10),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: RadioListTile(
                                activeColor: Colors.black,
                                value: index,
                                groupValue: myAddressCubit.selectedAddress,
                                onChanged: myAddressCubit.onRadioChanged,
                                title: Text(
                                  address.title ?? '_',
                                ),
                                subtitle: Text(
                                  '${address.city ?? ''} - ${address.area ?? ''} - ${address.block ?? ''} - ${address.street ?? ''} - ${address.apartmentNo ?? ''}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const BoxHelper(
                  height: 20,
                ),
                RegisterButton(
                  color: Colors.white,
                  removeElevation: true,
                  onPressed: () => NavigationService.push(
                      page: CreateNewAddressScreen.routeName,
                      // preventDuplicates: false,
                      arguments: myAddressCubit),
                  radius: 12,
                  title: 'create_new_address',
                ),
                if (myAddressCubit.addresses.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setWidth(10),
                    ),
                    child: Text(
                      'order_summary'.translate,
                      style: MainTheme.headerStyle3.copyWith(
                          // color: Theme.of(context).primaryColorconst,
                          ),
                    ),
                  ),
                  BoxHelper(
                    // height: 200,
                    child: CartTable(
                      isCheckout: true,
                      controller: scrollController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10),
                      vertical: ScreenUtil().setHeight(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'total_products'.translate.toTitleCase,
                              style: MainTheme.headerStyle3,
                            ),
                            Text(
                              '${context.read<CartCubit>().cartData?.total?.toStringAsFixed(3) ?? ''} ${'kd'.translate}',
                              style: MainTheme.headerStyle3,
                            ),
                          ],
                        ),
                        const BoxHelper(
                          height: 15,
                        ),
                        BlocBuilder<CheckoutCubit, CheckoutState>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'delivery'.translate.toTitleCase,
                                  style: MainTheme.headerStyle3,
                                ),
                                state is GetDeliveryPriceLoading
                                    ? const LoaderWidget()
                                    : Text(
                                        '${checkoutCubit.deliveryPrice.toStringAsFixed(2)} ${'kd'.translate}',
                                        style: MainTheme.headerStyle3,
                                      ),
                              ],
                            );
                          },
                        ),
                        const BoxHelper(
                          height: 15,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const BoxHelper(
                          height: 5,
                        ),
                        TotalView(
                          checkoutCubit: checkoutCubit,
                        ),
                        const BoxHelper(
                          height: 10,
                        ),
                        RegisterButton(
                          color: Colors.white,
                          removePadding: true,
                          removeElevation: true,
                          title: 'continue_payment',
                          radius: 13,
                          onPressed: () async {
                            // NavigationService.push(
                            //   page: CheckoutScreen.routeName,
                            // );
                            showDialog(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: myAddressCubit,
                                child:
                                    BlocBuilder<CheckoutCubit, CheckoutState>(
                                  builder: (context, state) {
                                    return Dialog(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            ScreenUtil().setWidth(10)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().setHeight(15),
                                              ),
                                              child: TotalView(
                                                checkoutCubit: checkoutCubit,
                                                showTitle: false,
                                                textColor: Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ScreenUtil().setWidth(10),
                                                vertical:
                                                    ScreenUtil().setHeight(5),
                                              ),
                                              child: Text(
                                                'choose_payment_method'
                                                    .translate,
                                                style: MainTheme.headerStyle3
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            RadioListTile(
                                              activeColor: Colors.black,
                                              value: 'credit',
                                              groupValue: checkoutCubit
                                                  .paymentMethod, // 'cash',
                                              onChanged: checkoutCubit
                                                  .onPaymentMethodChanged,
                                              title: Text('credit'.translate),
                                            ),
                                            RadioListTile(
                                              activeColor: Colors.black,
                                              value: 'cash',
                                              groupValue: checkoutCubit
                                                  .paymentMethod, // 'cash',
                                              onChanged: checkoutCubit
                                                  .onPaymentMethodChanged,
                                              title: Text('cash'.translate),
                                            ),
                                            state is CheckoutLoading
                                                ? const LoaderWidget(
                                                    color: Colors.black,
                                                  )
                                                : RegisterButton(
                                                    color: Colors.white,
                                                    onPressed: () =>
                                                        checkoutCubit
                                                            .checkout(context),
                                                    title: 'checkout',
                                                    radius: 12,
                                                    removeElevation: true,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class TotalView extends StatelessWidget {
  const TotalView({
    super.key,
    required this.checkoutCubit,
    this.showTitle = true,
    this.textColor,
  });
  final CheckoutCubit checkoutCubit;
  final bool showTitle;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          showTitle ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
      children: [
        Visibility(
          visible: showTitle,
          child: Text(
            'total'.translate.toTitleCase,
            style: MainTheme.headerStyle3.copyWith(
              color: textColor,
              fontSize: ScreenUtil().setSp(17),
            ),
          ),
        ),
        BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return Text(
              '${((context.read<CartCubit>().cartData?.total ?? 0) + (checkoutCubit.deliveryPrice)).toStringAsFixed(3)} ${'kd'.translate}',
              style: MainTheme.headerStyle3.copyWith(
                color: textColor,
                fontSize: ScreenUtil().setSp(17),
              ),
            );
          },
        ),
      ],
    );
  }
}
