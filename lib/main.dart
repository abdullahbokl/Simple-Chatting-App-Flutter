import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hey_chat/screens/chat_screen.dart';
import 'package:hey_chat/screens/login_screen.dart';
import 'package:hey_chat/screens/register_screen.dart';
import 'package:hey_chat/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'heyChat',
      initialRoute:
          (_auth.currentUser != null ? ChatScreen.screenRoute : WelcomeScreen.screenRoute),
      routes: {
        '/': (context) => WelcomeScreen(),
        WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
        RegisterScreen.screenRoute: (context) => RegisterScreen(),
        LoginScreen.screenRoute: (context) => LoginScreen(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
      },
    );
  }
}
