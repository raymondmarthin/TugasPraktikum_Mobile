import 'package:flutter/material.dart';
import 'helpers/mahasiswa_helper.dart';
import 'pages/list_mahasiswa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final helper = MahasiswaHelper();

    return MaterialApp(
      title: 'CRUD Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListMahasiswaPage(helper: helper),
    );
  }
}
