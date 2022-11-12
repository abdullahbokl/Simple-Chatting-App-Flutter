import 'package:flutter/material.dart';
import 'package:hey_chat/screens/register_screen.dart';
import 'package:hey_chat/widgets/my_button_widget.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const screenRoute = '/WelcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 180,
            child: Image.asset('images/logo.png'),
          ),
          const Text(
            'heyChat',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Color(0xff2e386b)),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyButton(
              title: 'Sign In',
              color: Colors.yellow[900]!,
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.screenRoute);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyButton(
              title: 'Register',
              color: Colors.blue[900]!,
              onPressed: () {
                Navigator.of(context).pushNamed(RegisterScreen.screenRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
