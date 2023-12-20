import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_assessment/models/contact_model.dart';
import 'package:flutter_assessment/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(ContactAdapter());
    await Hive.openBox<Contacts>('contacts');

    runApp(const MyApp());
  } catch (error) {
    print('Error: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(),
        appBarTheme: const AppBarTheme(
          color: Color(0xff32BAA5),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
