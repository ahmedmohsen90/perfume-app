import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/extensions/media_query.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/themes/themes.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';
import 'package:perfume/user/products/view/widgets/product_information_card.dart';
import 'package:perfume/user/products/viewModel/viewProduct/view_product_cubit.dart';
import 'package:readmore/readmore.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/components/register_button.dart';
import '../../../core/themes/screen_utility.dart';
import 'widgets/my_rich_text.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});
  static const routeName = '/view-product';

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  late ViewProductCubit viewProductCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int quantity = 1;
  bool isFav = false;

  @override
  void initState() {
    viewProductCubit = context.read<ViewProductCubit>()..viewProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocBuilder<ViewProductCubit, ViewProductState>(
        builder: (context, state) {
          if (state is ViewProductLoading) {
            return const LoaderWidget();
          }
          if (viewProductCubit.productData == null) {
            return Center(
              child: Text(
                'something_wrong'.translate,
                style: MainTheme.headerStyle3,
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BoxHelper(
                    width: double.infinity,
                    height: 300,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              viewProductCubit.carouselController
                                  .previousPage();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: Container(
                            width: context.width,
                            height: ScreenUtil().setHeight(370),
                            color: Colors.white,
                            child: CarouselSlider(
                              items: viewProductCubit.productData!.images!
                                  .map(
                                    (e) => Image.network(
                                      e.url ?? '',
                                      width: double.infinity,
                                      height: ScreenUtil().setHeight(370),
                                    ),
                                  )
                                  .toList(),
                              carouselController:
                                  viewProductCubit.carouselController,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                onPageChanged: (index, r) =>
                                    viewProductCubit.onPageChanged(index),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            viewProductCubit.carouselController.nextPage();
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  BoxHelper(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: ScrollablePositionedList.builder(
                            initialScrollIndex: viewProductCubit.page,
                            itemScrollController:
                                viewProductCubit.itemScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                viewProductCubit.productData!.images!.length,
                            itemBuilder: (_, index) {
                              var image =
                                  viewProductCubit.productData!.images![index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(10)),
                                child: InkWell(
                                    onTap: () =>
                                        viewProductCubit.onScrollChanged(
                                          index,
                                        ),
                                    child: viewProductCubit.page != index
                                        ? Container(
                                            color: Colors.white,
                                            child: Image.network(
                                              image.url ?? '',
                                              height:
                                                  ScreenUtil().setHeight(70),
                                              width: ScreenUtil().setWidth(70),
                                              // color: Colors.white10,
                                            ),
                                          )
                                        : Card(
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                color:
                                                    MainStyle.newLightGreyColor,
                                              ),
                                            ),
                                            margin: EdgeInsets.zero,
                                            child: ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                Colors.orange.withOpacity(0.9),
                                                BlendMode.color,
                                              ),
                                              child: Image.network(
                                                image.url ?? '',
                                                height:
                                                    ScreenUtil().setHeight(40),
                                                width:
                                                    ScreenUtil().setWidth(40),
                                                // color: Colors.white10,
                                              ),
                                            ),
                                          )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const BoxHelper(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            viewProductCubit.productData?.name ?? '',
                            style: MainTheme.headerStyle3.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${((double.tryParse(viewProductCubit.productData?.newPrice ?? '') ?? 0) * viewProductCubit.quantity).toStringAsFixed(2)} ${'kd'.translate}',
                                style: MainTheme.headerStyle3.copyWith(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(17),
                                ),
                              ),
                              Text(
                                '${((double.tryParse(viewProductCubit.productData?.oldPrice ?? '') ?? 0) * viewProductCubit.quantity).toStringAsFixed(2)} ${'kd'.translate}',
                                style: MainTheme.headerStyle3.copyWith(
                                  color: Colors.white,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                '${'you_save'.translate} ${(viewProductCubit.differenceBetweenPrice * viewProductCubit.quantity)} ${'kd'.translate} (${(viewProductCubit.differencePercentage * viewProductCubit.quantity).toStringAsFixed(0)} %)',
                                style: MainTheme.headerStyle3.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const BoxHelper(
                    height: 15,
                  ),
                  Text(
                    'description'.translate,
                    textAlign: TextAlign.start,
                    style: MainTheme.headerStyle3.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const BoxHelper(
                    height: 4,
                  ),
                  ReadMoreText(
                    viewProductCubit.productData?.description ?? '',
                    trimLines: 10,
                    colorClickableText: Colors.orange,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'show_more'.translate,
                    trimExpandedText: 'show_less'.translate,
                    style: MainTheme.headerStyle3.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const BoxHelper(
                    height: 14,
                  ),
                  ProductInformationCard(
                    viewProductCubit: viewProductCubit,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => viewProductCubit.changeQuantity(
                                  increment: false,
                                ),
                                child: const CustomizedCircleIcon(
                                  icons: Icons.remove,
                                ),
                              ),
                              BoxHelper(
                                width: 130,
                                child: Container(
                                  // height: ScreenUtil().setHeight(50),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: MainStyle.productCardColor,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(5),
                                    vertical: ScreenUtil().setHeight(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(15),
                                    vertical: ScreenUtil().setHeight(15),
                                  ),
                                  child: Text(
                                    '${viewProductCubit.quantity}',
                                    textAlign: TextAlign.center,
                                    style: MainTheme.headerStyle3.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => viewProductCubit.changeQuantity(),
                                child: const CustomizedCircleIcon(
                                  icons: Icons.add,
                                ),
                              ),
                            ],
                          ),
                          const BoxHelper(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BoxHelper(
                                width: 6.5,
                              ),
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  if (state is AddToCartLoading) {
                                    return const LoaderWidget();
                                  }
                                  return Expanded(
                                    // flex: 2,
                                    child: SizedBox(
                                      width: ScreenUtil().setWidth(120),
                                      height: ScreenUtil().setHeight(50),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: RegisterButton(
                                          color: Colors.white,
                                          removePadding: true,
                                          removeElevation: true,
                                          icon: Icon(
                                            Icons.add_shopping_cart,
                                            size: ScreenUtil().radius(20),
                                            color: Colors.black,
                                          ),
                                          radius: 12,
                                          title: 'add_to_cart',
                                          onPressed: () => context
                                              .read<CartCubit>()
                                              .addToCart(
                                                productId: viewProductCubit
                                                    .productData?.id,
                                                quantity:
                                                    viewProductCubit.quantity,
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const BoxHelper(
                                width: 6.5,
                              ),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isFav = !isFav;
                                      });
                                    },
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isFav ? Colors.black : Colors.white,
                                      size: ScreenUtil().radius(35),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomizedCircleIcon extends StatelessWidget {
  const CustomizedCircleIcon({
    Key? key,
    required this.icons,
  }) : super(key: key);
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const CircleBorder(),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
        child: Icon(
          icons,
        ),
      ),
    );
  }
}
