import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jagl/splash.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const Myapp());
  
}
class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
}
}