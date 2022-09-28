import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/themes/themes.dart';
import 'package:perfume/user/settings/viewModel/settings/settings_cubit.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});
  static const routeName = '/about-us';
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late SettingsCubit settingsCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    settingsCubit = context.read<SettingsCubit>()..getSettingsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const LoaderWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                  child: Text(
                    settingsCubit.settingsData?.about ??
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: MainTheme.headerStyle3.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
