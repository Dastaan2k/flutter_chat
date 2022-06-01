import 'dart:html';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_to_text_chat/views/misc/hex_color.dart';
import 'package:voice_to_text_chat/wrapper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //SharedPreferences pref = await SharedPreferences.getInstance();
  //pref.clear();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBg1mR4448zCH54a0LISGdplCR2bOHIr1E',
        appId: '1:759699776050:web:7f5bff29b9d2349811122b',
        messagingSenderId: '759699776050',
        projectId: 'flutter-chat-6c05f',
        authDomain: 'flutter-chat-6c05f.firebaseapp.com',
        databaseURL: 'https://flutter-chat.firebaseio.com',
        storageBucket: 'flutter-chat-6c05f.appspot.com',
        measurementId: 'G-XVVT4ZP9CT',
      ),
    );
  }

  await FirebaseAuth.instance.setPersistence(Persistence.NONE);

  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const MyApp());
}


/*

const firebaseConfig = {
    apiKey: "AIzaSyBg1mR4448zCH54a0LISGdplCR2bOHIr1E",
    authDomain: "flutter-chat-6c05f.firebaseapp.com",
    projectId: "flutter-chat-6c05f",
    storageBucket: "flutter-chat-6c05f.appspot.com",
    messagingSenderId: "759699776050",
    appId: "1:759699776050:web:7f5bff29b9d2349811122b",
    measurementId: "G-XVVT4ZP9CT"
  };

 */

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Chat',
      home: NeumorphicApp(
        title: 'Flutter Chat',
        themeMode: ThemeMode.dark,
        theme: NeumorphicThemeData(
          baseColor: HexColor('e6e7ee'),
          shadowLightColorEmboss: Colors.white
        ),
        darkTheme: NeumorphicThemeData.dark(
          baseColor: HexColor('26282d'),
          shadowDarkColor: Colors.black.withOpacity(0.85),
          shadowLightColor: Colors.grey.shade300.withOpacity(0.5),
          shadowLightColorEmboss: Colors.grey.withOpacity(0.5),
          shadowDarkColorEmboss: Colors.black.withOpacity(0.65),
        ),
        home: const Wrapper(),
      ),
    );
  }
}
