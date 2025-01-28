import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:postitup/app/services/board_service.dart';

class BoardController extends GetxController {
  String? id;

  @override
  void onInit() {
    super.onInit();

    id = Get.parameters['id'];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPostitItems() {
    return BoardService().getPostitItems(boardId: id!);
  }

  Future<void> createNewPostit({required String content}) async {
    //
    try {
      await BoardService().createNewPostit(
        boardId: id,
        content: content,
      );
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  updatePostIt(
      {required String boardId,
      required String postitId,
      required double top,
      required double left}) async {
    await BoardService().updatePostIt(
        boardId: boardId, postitId: postitId, left: left, top: top);
  }
}
