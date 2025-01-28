import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../views/views/has_error_view.dart';
import '../../../views/views/loaddata_view.dart';
import '../controllers/home_controller.dart';
import 'listboard_view.dart';
import 'profile_button_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boards'),
        centerTitle: false,
        actions: [
          //
          ProfileButtonView()
        ],
      ),
      body: StreamBuilder(
        stream: controller.getUserBoard(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          // has error
          if (snapshot.hasError) {
            return HasErrorView(
              error: snapshot.error!,
            );
          }

          // has data
          if (snapshot.hasData) {
            final board = snapshot.data;
            return ListboardView(boards: board!.docs);
          }

          // loading...
          return LoadingView();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add new board
          controller.createNewBoard();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
