import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../services/board_service.dart';
import '../../board/controllers/board_controller.dart';

class HomeController extends GetxController {
  // create new board
  Future<void> createNewBoard() async {
    try {
      final board = await BoardService().createNewBoard();
      final boardId = board.id;
      openBoard(boardId: boardId);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  // get user's board
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserBoard() {
    return BoardService().getBoard(uid: AuthService().getCurrentUser()!.uid);
  }

  // open board page
  void openBoard({required String boardId}) {
    final boardController = Get.find<BoardController>();
    boardController.id = boardId;
    Get.toNamed(Routes.BOARD, parameters: {'id': boardId});
  }
}
