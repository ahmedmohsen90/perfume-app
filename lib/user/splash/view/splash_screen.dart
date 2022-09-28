import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/extensions/media_query.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/home/view/home_screen.dart';
import 'package:perfume/user/token/viewModel/generateUniqueToken/generate_unique_token_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../cart/viewModel/cart/cart_cubit.dart';
import '../../favorites/viewModel/favorites/favorites_cubit.dart';
import '../viewModel/splash/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashCubit splashCubit;

  @override
  void initState() {
    // stopwatc
    splashCubit = context.read<SplashCubit>()..initVideoController();
    Future.delayed(
      const Duration(seconds: 9),
      () {
        context.read<GenerateUniqueTokenCubit>().generateToken().then((value) {
          context.read<FavoritesCubit>().getFavList();
          context.read<CartCubit>().getMyCartItems();
        });
        NavigationService.pushReplacementAll(
          page: HomeScreen.routeName,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          if (state is Initializing) {
            return const LoaderWidget();
          }
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                // width: context.width,
                // height: context.height,
                width: context.width,
                height: context.height,
                child: VideoPlayer(
                  splashCubit.playerController,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
