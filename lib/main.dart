import 'package:flutter/material.dart';
import 'package:responsi/helpers/user_info.dart';
import 'package:responsi/ui/tugas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Widget page = const CircularProgressIndicator();

  // @override
  // void initState() {
  //   super.initState();
  //   isLogin();
  // }

  // void isLogin() async {
  //   var token = await UserInfo().getToken();
  //   if (token != null) {
  //     setState(() {
  //       page = const TugasPage();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Kita',
      debugShowCheckedModeBanner: false,
      home: const TugasPage(),
    );
  }
}
