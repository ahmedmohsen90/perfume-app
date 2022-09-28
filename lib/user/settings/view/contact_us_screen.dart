import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/register_button.dart';
import 'package:perfume/core/components/register_field.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/user/settings/viewModel/contactUs/contact_us_cubit.dart';

import '../../../core/themes/themes.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});
  static const routeName = '/contact-us';

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ContactUsCubit contactUsCubit;

  @override
  void initState() {
    contactUsCubit = context.read<ContactUsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: contactUsCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(5),
                ),
                child: Text(
                  'contact_us'.translate,
                  textAlign: TextAlign.center,
                  style: MainTheme.headerStyle3.copyWith(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(17),
                  ),
                ),
              ),
              RegisterField(
                labelText: 'name',
                controller: contactUsCubit.nameController,
                validator: contactUsCubit.nameValidate,
              ),
              RegisterField(
                labelText: 'email',
                controller: contactUsCubit.emailController,
                validator: contactUsCubit.emailValidate,
                keyboardType: TextInputType.emailAddress,
              ),
              RegisterField(
                labelText: 'mobile',
                controller: contactUsCubit.mobileController,
                validator: contactUsCubit.mobileValidate,
                keyboardType: TextInputType.phone,
              ),
              RegisterField(
                labelText: 'subject',
                controller: contactUsCubit.subjectController,
                validator: contactUsCubit.subjectValidate,
              ),
              RegisterField(
                hintText: 'message',
                maxLines: 6,
                controller: contactUsCubit.messageController,
                validator: contactUsCubit.messageValidate,
              ),
              const BoxHelper(
                height: 10,
              ),
              BlocBuilder<ContactUsCubit, ContactUsState>(
                builder: (context, state) {
                  if (state is ContactUsLoading) {
                    return const LoaderWidget();
                  }
                  return RegisterButton(
                    title: 'send',
                    onPressed: () => contactUsCubit.submit(),
                    radius: 12,
                  );
                },
              ),
              const BoxHelper(
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
