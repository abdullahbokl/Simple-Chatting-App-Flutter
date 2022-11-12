import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hey_chat/screens/chat_screen.dart';
import '../widgets/build_text_form_field_widget.dart';
import '../widgets/my_button_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const screenRoute = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  bool showIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              title: 'Login',
              color: Colors.blue,
              onPressed: () async {
                setState(() {
                  showIndicator = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.screenRoute);
                    setState(() {
                      showIndicator = false;
                    });
                  }
                } catch (error) {
                  setState(() {
                    showIndicator = false;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("OOOOOOPS"),
                        content: Text('${error}'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: const Text("okay"),
                          ),
                        ],
                      ),
                    );

                  });
                }
              },
            )
          ],
        ),
      ),
    );
    ;
  }
}
