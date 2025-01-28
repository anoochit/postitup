import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HasErrorView extends GetView {
  const HasErrorView({
    super.key,
    required this.error,
  });

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$error'));
  }
}
