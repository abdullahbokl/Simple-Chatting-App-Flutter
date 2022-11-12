import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {

  final String title;
  final Function onChanged;
  final TextInputType KeyboardType;
  final bool obscurePassword;

  BuildTextFormField({required this.title, required this.onChanged, required this.KeyboardType, required this.obscurePassword});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                obscureText: obscurePassword,
                keyboardType: KeyboardType,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  labelText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.orange,
                    ),
                  ),
                ),
                onChanged: (value) => onChanged(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
