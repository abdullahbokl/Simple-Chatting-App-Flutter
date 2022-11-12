import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  MyButton({required this.title, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: color,
        child: MaterialButton(
          height: 42,
          minWidth: 200,
          onPressed: () => onPressed(),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
