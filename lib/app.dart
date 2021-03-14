import 'package:flutter/material.dart';
import 'package:keepscore/pages/profile.dart';

class AppFrame extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keepscore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,

      // home: MyHomePage(title: 'Keepscore'),
    );
  }
}
