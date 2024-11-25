import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_with_note_app/screens/all_notes.dart';
import 'package:sqflite_with_note_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllNotes(),
      

      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => const Home()),
      //   GetPage(name: '/all-notes', page: () => const AllNotes()), // Define route for AllNotes
      // ],

    );
  }
}