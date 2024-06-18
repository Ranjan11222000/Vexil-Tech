import 'package:flutter/material.dart';
import 'text_style.dart';

class EditText extends StatelessWidget {
  String? hintText;
  IconData? prefixIcon, suffixIcon;
  bool isPasswordType;
  Color textColor;
  TextEditingController controller;
  VoidCallback? iconPressed;
  TextInputType? keyBoardType;
  TextStyle? hintStyle;
  String? Function(String?)? validator;
  String? Function(String?)? onChanged;

  EditText(
      {super.key,
        required this.hintText,
        required this.controller,
        this.prefixIcon,
        this.suffixIcon,
        this.isPasswordType=false,
        this.textColor=Colors.black,
        this.iconPressed,
        this.keyBoardType= TextInputType.text,
        this.validator,
        this.onChanged});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 13.5, horizontal: 15.0),
        hintText: hintText,
        hintStyle: hintStyle ?? text4().copyWith(color:Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: Colors.blue,
        )
            : null,
        suffixIcon: suffixIcon != null
            ? isPasswordType
            ? IconButton(
            onPressed: iconPressed,
            icon: Icon(
              suffixIcon,
              color: Colors.grey,
            ))
            : IconButton(
            onPressed: iconPressed,
            icon: Icon(suffixIcon, color: Colors.grey))
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: Colors.grey)),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      style: text6().copyWith(color: textColor),
      keyboardType: isPasswordType ? TextInputType.visiblePassword : keyBoardType,
    );
  }
}
