import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/extensions/media_query.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/navigator.dart';
import 'package:perfume/user/home/view/home_screen.dart';
import 'package:provider/provider.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({
    Key? key,
    this.isSuccess = true,
    this.message,
  }) : super(key: key);

  final bool isSuccess;
  final String? message;
  static const routeName = '/payment-status-screen';

  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (widget.isSuccess) {
          Phoenix.rebirth(context);
          NavigationService.pushReplacementAll(
            page: HomeScreen.routeName,
          );
        } else {
          NavigationService.goBack();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('payment'.translate),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              !widget.isSuccess
                  ? 'assets/icons/error.svg'
                  : 'assets/icons/check_circle.svg',
              height: ScreenUtil().setHeight(120),
              color: !widget.isSuccess ? Colors.red : Colors.black,
            ),
          ),
          const BoxHelper(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.message ??
                    (!widget.isSuccess ? 'payment_failed' : 'payment_success')
                        .translate,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !widget.isSuccess ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
