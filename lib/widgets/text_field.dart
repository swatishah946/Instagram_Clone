import 'package:flutter/material.dart';

class TextFieldInput
 extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  const TextFieldInput({Key?key,required this.textEditingController,required this.hintText, this.isPass=false, required this.textInputType}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final InputBorder=OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
        );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder,
        enabledBorder: InputBorder,
        focusedBorder: InputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8)

      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}