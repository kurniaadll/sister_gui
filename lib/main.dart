import 'package:flutter/material.dart';
import 'package:mahasiswa_sister/first_page.dart';
import 'package:mahasiswa_sister/mahasiswa/data_mahasiswa.dart';
import 'package:mahasiswa_sister/mahasiswa/edit_mahasiswa.dart';
import 'package:mahasiswa_sister/mahasiswa/insert_mahasiswa.dart';
import 'package:mahasiswa_sister/mahasiswa/list_mahasiswa.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.light(
          primary: Color.fromRGBO(252, 98, 38, 1.0),
        )
      ),
      home: LandingPage(),
    );
  }
}

