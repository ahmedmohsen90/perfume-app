import '../extensions/string.dart';
import '../components/sized_box_helper.dart';
import 'package:flutter/material.dart';
import 'package:perfume/core/themes/themes.dart';

class LoadingMoreView extends StatelessWidget {
  const LoadingMoreView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.7,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
            // const BoxHelper(
            //   width: 8,
            // ),
            // Expanded(
            //   child: Text(
            //     'loading'.translate,
            //     overflow: TextOverflow.ellipsis,
            //     style: MainTheme.headerStyle3.copyWith(
            //       color: Theme.of(context).primaryColor,
            //       // fontSize: null,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
