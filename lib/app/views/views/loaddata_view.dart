import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoadingView extends GetView {
  const LoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
