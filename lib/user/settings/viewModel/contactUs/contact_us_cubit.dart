import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfume/core/extensions/string.dart';
import 'package:perfume/core/helper/laravel_exception.dart';
import 'package:perfume/user/settings/repo/contact_us_repo.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();

  String? emailValidate(String? v) {
    if (v!.isEmpty) {
      return ('email_required').translate;
    }
    return null;
  }

  String? nameValidate(String? v) {
    if (v!.isEmpty) {
      return ('name_required').translate;
    }
    return null;
  }

  String? mobileValidate(String? v) {
    if (v!.isEmpty) {
      return ('mobile_required').translate;
    }
    return null;
  }

  String? subjectValidate(String? v) {
    if (v!.isEmpty) {
      return ('subject_required').translate;
    }
    return null;
  }

  String? messageValidate(String? v) {
    if (v!.isEmpty) {
      return ('message_required').translate;
    }
    return null;
  }

  Future<void> submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var validate = formKey.currentState?.validate() ?? false;

    if (!validate) {
      return;
    }
    emit(ContactUsLoading());
    try {
      var contactUsData = await ContactUsRepo.contactUs(
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'mobile': mobileController.text,
          'subject': subjectController.text,
          'message': messageController.text,
        },
      );
      if (contactUsData == null) {
        emit(ContactUsError());
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        return;
      }
      Fluttertoast.showToast(
        msg: contactUsData.message ?? '',
        backgroundColor: contactUsData.success == false ? Colors.red : null,
      );
      if (contactUsData.success == true) {
        messageController.clear();
        subjectController.clear();
      }
      emit(ContactUsDone());
    } on LaravelException catch (error) {
      Fluttertoast.showToast(
        msg: error.exception,
      );
      emit(ContactUsError());
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    subjectController.dispose();
    messageController.dispose();
    return super.close();
  }
}
