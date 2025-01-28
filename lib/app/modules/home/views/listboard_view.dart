import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class ListboardView extends GetView<HomeController> {
  const ListboardView({super.key, required this.boards});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> boards;
  @override
  Widget build(BuildContext context) {
    final crossAxisCount = (context.width >= 768)
        ? 4
        : (context.width >= 640)
            ? 2
            : 1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 4 / 3,
      ),
      itemCount: boards.length,
      itemBuilder: (BuildContext context, int index) {
        final id = boards[index].id;
        final title = boards[index]['title'];
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.2,
          child: InkWell(
            onTap: () => controller.openBoard(boardId: id),
            child: Center(child: Text(title)),
          ),
        );
      },
    );
  }
}
