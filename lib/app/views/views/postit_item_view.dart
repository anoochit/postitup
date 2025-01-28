import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PostItItemView extends GetView {
  const PostItItemView({super.key, required this.content, required this.color});
  final String content;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 3.0,
      child: Container(
        width: 200,
        height: 200,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
