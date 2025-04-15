import 'package:flutter/material.dart';

class CustomActiveBluetoothPopup extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;
  final double? width; 
  final double? height; 

  const CustomActiveBluetoothPopup({
    super.key,
    required this.content,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.8, 
        height: height, 
        child: Text(content),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('ativar'),
        ),
      ],
    );
  }
}