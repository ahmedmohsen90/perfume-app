// import 'dart:developer';

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../core/themes/screen_utility.dart';
// import '../../../core/themes/themes.dart';
// import '../../core/extensions/string.dart';
// import '../../core/components/sized_box_helper.dart';
// import '../viewModel/lang/lang_cubit.dart';
// import 'widgets/change_language_widget.dart';
// import 'widgets/language_item.dart';

// class ChangeLanguageScreen extends StatelessWidget implements AutoRouteWrapper {
//   const ChangeLanguageScreen({Key? key}) : super(key: key);
//   static const routeName = '/change-lang';
//   @override
//   Widget build(BuildContext context) {
//     log(context.routeData.name);
//     var langCubit = context.read<LangCubit>();
//     return Scaffold(
//       body: Column(
//         // crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 35),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Image.asset(
//                   'assets/icons/trkarLogoWhite.png',
//                   height: ScreenUtil().setHeight(115),
//                   alignment: Alignment.center,
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             'choose_lang'.translate,
//             textAlign: TextAlign.center,
//             style: MainTheme.headerStyle1.copyWith(
//               color: Colors.black,
//             ),
//           ),
//           const Spacer(),
//           BlocBuilder<LangCubit, LangState>(
//             builder: (context, state) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//                 child: Column(
//                   children: List.generate(
//                     langCubit.langs.length,
//                     (index) {
//                       var langItem = langCubit.langs[index];
//                       return LanguageItem(
//                         isSelected: langCubit.currentLanguage == langItem.code,
//                         title: langItem.language,
//                         imagePath: langItem.flag,
//                         onPressed: () => langCubit.chooseLanguage(
//                           langItem.code,
//                           context,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//           const Spacer(),
//           const ChooseLangWidget(),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget wrappedRoute(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LangCubit(),
//       child: this,
//     );
//   }
// }
