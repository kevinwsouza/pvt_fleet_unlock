import 'package:flutter/material.dart';

class CustomErrorPopup extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback onPressed;
  final double? width; 
  final double? height; 

  const CustomErrorPopup({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.8, 
        height: height, 
        child: Text(content),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}