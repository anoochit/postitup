// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../middlewares/route_guard.dart';
import '../modules/board/bindings/board_binding.dart';
import '../modules/board/views/board_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.BOARD,
      page: () => const BoardView(),
      binding: BoardBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
    ),
  ];
}
