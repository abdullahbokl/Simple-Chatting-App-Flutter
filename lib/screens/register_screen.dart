import 'package:flutter/material.dart';
import 'package:hey_chat/screens/chat_screen.dart';
import 'package:hey_chat/widgets/my_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/build_text_form_field_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static const screenRoute = '/RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;

  late String password;

  bool showIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showIndicator,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/logo.png'),
            ),
            BuildTextFormField(
              title: 'Enter your email',
              onChanged: (value) {
                email = value;
              },
              KeyboardType: TextInputType.emailAddress,
              obscurePassword: false,
            ),
            BuildTextFormField(
              title: 'Enter your password',
              onChanged: (value) {
                password = value;
              },
              KeyboardType: TextInputType.visiblePassword,
              obscurePassword: true,
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              title: 'Register',
              color: Colors.blue,
              onPressed: () async {
                setState(() {
                  showIndicator = true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.screenRoute);
                  setState(() {
                    showIndicator = false;
                  });
                } catch (error) {
                  print(error);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
