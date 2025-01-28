import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:postitup/app/services/auth_service.dart';

class ProfileButtonView extends GetView {
  const ProfileButtonView({super.key});
  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().getCurrentUser()?.email ?? '';
    final profileName = currentUser.substring(0, 1).toUpperCase();
    return CircleAvatar(
      child: Text(profileName),
    );
  }
}
