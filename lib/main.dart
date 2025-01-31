import 'package:chat_app_3/pages/chatpage.dart';
import 'package:chat_app_3/pages/forgotpassword.dart';
import 'package:chat_app_3/pages/home.dart';
import 'package:chat_app_3/pages/signin.dart';
import 'package:chat_app_3/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'firebase_options.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: "AIzaSyArzIR4k4TVepAdlwoihFVbeYl3Z_3gkSA",
  //       appId: "1:749584590064:web:baf81b84a347247b02ce35",
  //       messagingSenderId: "749584590064",
  //       projectId: "chat-app-3-1c701",
  //     ),
  //   );
  // }
  WidgetsFlutterBinding.ensureInitialized();

  const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyArzIR4k4TVepAdlwoihFVbeYl3Z_3gkSA",
    appId: "1:749584590064:web:baf81b84a347247b02ce35",
    messagingSenderId: "749584590064",
    projectId: "chat-app-3-1c701",
  );

  await Firebase.initializeApp(
    name: "chat-app-3-1c701",
    options: firebaseOptions,
  );

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignIn(),
      // home: SignUp(),
      // home: Home(),
      // home: ChatPage(),
      // home: ForgotPassword(),
    );
  }
}
