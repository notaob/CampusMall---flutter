import 'package:campusmall/pages/Login/index.dart';
import 'package:campusmall/pages/Main/index.dart';
import 'package:flutter/material.dart';

Widget getRootWidget() {
  return MaterialApp(
    initialRoute: '/',
    routes: getRoutes(),
  );
}

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/': (context) => MainPage(),
    '/login': (context) => LoginPage(),                           
  };
}