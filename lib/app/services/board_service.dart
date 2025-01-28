import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'auth_service.dart';

class BoardService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user's board
  Stream<QuerySnapshot<Map<String, dynamic>>> getBoard({required String uid}) {
    try {
      return _firestore
          .collection('boards')
          .where('uid', isEqualTo: uid)
          .orderBy('modified', descending: true)
          .snapshots();
    } catch (e) {
      throw ('$e');
    }
  }

  // create new board
  Future<DocumentReference<Map<String, dynamic>>> createNewBoard() async {
    final uid = AuthService().getCurrentUser()!.uid;
    final dateTime = DateTime.now();

    try {
      final board = await _firestore.collection('boards').add({
        "title": dateTime.toIso8601String(),
        "modified": dateTime,
        "uid": uid,
      });

      return board;
    } catch (e) {
      throw ('$e');
    }
  }

  // get postit items in board
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostitItems(
      {required String boardId}) {
    try {
      return _firestore
          .collection('boards')
          .doc(boardId)
          .collection('items')
          .orderBy('modified', descending: false)
          .snapshots();
    } catch (e) {
      throw ('$e');
    }
  }

  // create new postit
  Future<DocumentReference<Map<String, dynamic>>> createNewPostit(
      {required String content, String? boardId}) async {
    try {
      final uid = AuthService().getCurrentUser()!.uid;
      final dateTime = DateTime.now();
      return await _firestore
          .collection('boards')
          .doc(boardId)
          .collection('items')
          .add(
        {
          "offsetX": 0.0,
          "offsetY": 0.0,
          "content": content,
          "modified": dateTime,
          "uid": uid,
        },
      );
    } catch (e) {
      throw ('$e');
    }
  }

  // update postit position
  Future<void> updatePostIt(
      {required String postitId,
      required double left,
      required double top,
      required String boardId}) async {
    await _firestore
        .collection('boards')
        .doc(boardId)
        .collection('items')
        .doc(postitId)
        .update({
      'offsetX': left,
      'offsetY': top,
      "modified": DateTime.now(),
    });
  }
}
