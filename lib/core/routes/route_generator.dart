import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfume/user/addresses/view/addresses_screen.dart';
import 'package:perfume/user/addresses/view/create_new_address_screen.dart';
import 'package:perfume/user/addresses/viewModel/createNewAddress/create_new_address_cubit.dart';
import 'package:perfume/user/addresses/viewModel/myAddress/my_address_cubit.dart';
import 'package:perfume/user/cart/view/cart_screen.dart';
import 'package:perfume/user/categories/view/products_by_category_screen.dart';
import 'package:perfume/user/categories/viewModel/productsByCategory/products_by_category_cubit.dart';
import 'package:perfume/user/checkout/view/checkout_screen.dart';
import 'package:perfume/user/checkout/view/payment_success_screen.dart';
import 'package:perfume/user/checkout/view/webview_screen.dart';
import 'package:perfume/user/favorites/view/favorites_screen.dart';
import 'package:perfume/user/home/view/home_screen.dart';
import 'package:perfume/user/products/view/view_product_screen.dart';
import 'package:perfume/user/products/viewModel/viewProduct/view_product_cubit.dart';
import 'package:perfume/user/search/view/search_screen.dart';
import 'package:perfume/user/search/viewModel/searchProducts/search_products_cubit.dart';
import 'package:perfume/user/settings/view/about_us_screen.dart';
import 'package:perfume/user/settings/view/contact_us_screen.dart';
import 'package:perfume/user/settings/viewModel/contactUs/contact_us_cubit.dart';
import 'package:perfume/user/splash/view/splash_screen.dart';
import 'package:perfume/user/splash/viewModel/splash/splash_cubit.dart';

import '../../user/addresses/viewModel/areas/areas_cubit.dart';
import '../../user/addresses/viewModel/cities/cities_cubit.dart';

class RouteGenerator {
  static Route<dynamic>? onRouteGenerated(RouteSettings settings) {
    var name = settings.name;

    switch (name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => SearchProductsCubit(),
            child: const SearchScreen(),
          ),
        );
      case ContactUsScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ContactUsCubit(),
            child: const ContactUsScreen(),
          ),
        );
      case AboutUsScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AboutUsScreen(),
        );
      case FavoritesScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FavoritesScreen(),
        );
      case PaymentSuccessScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            var json = settings.arguments as Map<String, dynamic>?;
            return PaymentSuccessScreen(
              isSuccess: json?['success'] ?? false,
              message: json?['message'] ?? '',
            );
          },
        );
      case WebViewScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => WebViewScreen(
            url: settings.arguments as String,
          ),
        );
      case MyAddressesScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => MyAddressCubit(),
            child: const MyAddressesScreen(),
          ),
        );
      case CreateNewAddressScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AreasCubit(),
              ),
              BlocProvider(
                create: (_) => CitiesCubit(),
              ),
              BlocProvider(
                create: (_) => CreateNewAddressCubit(),
              ),
              BlocProvider.value(
                value: settings.arguments as MyAddressCubit,
              ),
            ],
            child: const CreateNewAddressScreen(),
          ),
        );
      case CartScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartScreen(),
        );
      case CheckoutScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CheckoutScreen(),
        );
      case ProductsByCategoryScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            var map = settings.arguments as Map<String, dynamic>?;
            return BlocProvider(
              create: (_) => ProductsByCategoryCubit(
                categorySlug: map?['category_slug'],
                categoryName: map?['category_name'],
              ),
              child: const ProductsByCategoryScreen(),
            );
          },
        );
      case ViewProductScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            var map = settings.arguments as Map<String, dynamic>?;
            return BlocProvider(
              create: (_) => ViewProductCubit(
                productSlug: map?['product_slug'],
              ),
              child: const ViewProductScreen(),
            );
          },
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
              create: (_) => SplashCubit(), child: const SplashScreen()),
        );
    }
  }
}
