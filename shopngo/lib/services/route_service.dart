import 'package:flutter/material.dart';
import '/screens/login_screen.dart';
import '/screens/signup_screen.dart';
import '/screens/home_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/categories_screen.dart';


class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String additem = '/additem';
  static const String profile = '/profile';
  static const String category = '/category';
  static const String wishlist = '/wishlist';
  static const String cart = '/cart';
  static const String settings = '/settings';
  static const String notification = '/notifications';
  static const String allitems = '/allitems';
  static const String feedback = '/feedback';
  static const String passwordsecurity = '/passwordsecurity';
  static const String privacypermissions = '/privacypermissions';
  static const String chatlist = '/chatlist';
  static const String callnow = '/callnow';
  static const String sendemail = '/sendemail';
  static const String listing = '/listing';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => SignupScreen(),
    home: (context) => HomeScreen(),
    profile: (context) => ProfileScreen(),
    category: (context) => CategoriesScreen(),

  };
}
