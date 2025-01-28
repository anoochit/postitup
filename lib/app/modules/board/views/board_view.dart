import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../views/views/has_error_view.dart';
import '../../../views/views/loaddata_view.dart';
import '../../../views/views/postit_item_view.dart';
import '../controllers/board_controller.dart';

class BoardView extends GetView<BoardController> {
  const BoardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: controller.getPostitItems(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          // has error
          if (snapshot.hasError) {
            return HasErrorView(error: snapshot.error!);
          }

          // has data
          if (snapshot.hasData) {
            final items = snapshot.data!.docs;
            return Stack(
              children: List.generate(items.length, (index) {
                final content = items[index]['content'];
                final top = items[index]['offsetY'];
                final left = items[index]['offsetX'];
                final id = items[index].id;
                return Positioned(
                  top: top,
                  left: left,
                  child: Draggable<String>(
                    data: id,
                    feedback: PostItItemView(
                      content: content,
                      color: Colors.purple.shade200,
                    ),
                    childWhenDragging: PostItItemView(
                      content: '',
                      color: Colors.purple.shade100,
                    ),
                    child: PostItItemView(
                      content: content,
                      color: Colors.purple.shade200,
                    ),
                  ),
                );
              })
                ..add(
                  DragTarget(
                    builder: (context, candidateData, rejectedData) {
                      return Container();
                    },
                    onAcceptWithDetails: (details) async {
                      //
                      log('offset ${details.offset.dx},${details.offset.dy}');
                      await controller.updatePostIt(
                        boardId: controller.id!,
                        postitId: details.data.toString(),
                        left: details.offset.dx,
                        top: details.offset.dy - kToolbarHeight,
                      );
                    },
                  ),
                ),
            );
          }

          // loading
          return LoadingView();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewPostIt(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _createNewPostIt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final postItController = TextEditingController();
        return AlertDialog(
          title: Text('New post'),
          content: Flexible(
            child: TextField(
              controller: postItController,
              decoration: InputDecoration(
                hintText: 'Enter your text here!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              maxLines: null,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // create new post
                await controller.createNewPostit(
                  content: postItController.text,
                );
                Get.back();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
