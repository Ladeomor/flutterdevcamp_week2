import 'package:get/get.dart';
import 'package:news_app/screens/home_screen.dart';

class Routes{
  Routes._();
  static const initial = '/homeScreen';

  static final route = [
    GetPage(name: '/homeScreen', page: () => HomeScreen(), transition: Transition.fadeIn)
  ];
}