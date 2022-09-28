import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/helper/app_localization.dart';
import 'package:perfume/core/routes/route_generator.dart';
import 'package:perfume/localization/viewModel/lang/lang_cubit.dart';
import 'package:perfume/user/addresses/viewModel/areas/areas_cubit.dart';
import 'package:perfume/user/addresses/viewModel/cities/cities_cubit.dart';
import 'package:perfume/user/addresses/viewModel/createNewAddress/create_new_address_cubit.dart';
import 'package:perfume/user/addresses/viewModel/myAddress/my_address_cubit.dart';
import 'package:perfume/user/cart/viewModel/cart/cart_cubit.dart';
import 'package:perfume/user/categories/viewModel/catgories/categories_cubit.dart';
import 'package:perfume/user/checkout/viewModel/checkout/checkout_cubit.dart';
import 'package:perfume/user/favorites/viewModel/favorites/favorites_cubit.dart';
import 'package:perfume/user/home/view/home_screen.dart';
import 'package:perfume/user/home/viewModel/home/home_cubit.dart';
import 'package:perfume/user/settings/viewModel/settings/settings_cubit.dart';
import 'package:perfume/user/token/viewModel/generateUniqueToken/generate_unique_token_cubit.dart';

import 'core/helper/navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FavoritesCubit(),
          ),
          BlocProvider(
            create: (_) => SettingsCubit(),
          ),
          BlocProvider(
            create: (_) => CheckoutCubit(),
          ),
        
          BlocProvider(
            create: (_) => MyAddressCubit(),
          ),
          BlocProvider(
            create: (_) => HomeCubit(),
          ),
          BlocProvider(
            create: (_) => CartCubit(),
          ),
          BlocProvider(
            create: (_) => CategoriesCubit(),
          ),
          BlocProvider(
            create: (_) => LangCubit(),
          ),
          BlocProvider(
            create: (_) => GenerateUniqueTokenCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'غيور',
          locale: localization.locale,
          supportedLocales: localization.supportedLocales(),
          builder: (ctx, widget) => ScreenUtilInit(
            builder: (_, __) => widget ?? const SizedBox(),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
           
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: Color(0xffE3C231),
          ),
          // initialRoute: HomeScreen.routeName,
          navigatorKey: NavigationService.navigationKey,
          onGenerateRoute: RouteGenerator.onRouteGenerated,
        ));
  }
}
