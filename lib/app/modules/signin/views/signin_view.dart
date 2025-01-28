import 'dart:developer';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
      ],
      actions: [
        AuthStateChangeAction<SignedIn>(
          (context, state) {
            log('user = ${state.user?.uid}');
            Get.offAllNamed(Routes.HOME);
          },
        ),
        AuthStateChangeAction<UserCreated>(
          (context, state) {
            Get.offAllNamed(Routes.HOME);
          },
        )
      ],
    );
  }
}
