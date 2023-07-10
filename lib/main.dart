import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_app/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCZQZTUOrf2hjSVn-zPwLL0nYzFJrp3uwk",
          authDomain: "musictube-4e26a.firebaseapp.com",
          projectId: "musictube-4e26a",
          storageBucket: "musictube-4e26a.appspot.com",
          messagingSenderId: "796295928676",
          appId: "1:796295928676:web:6b7c7325a33ff009b6f871",
          measurementId: "G-9W79F4Y2ZB"),
    );
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

