import 'package:app_admin/view_models/styles/my_color.dart';
import 'package:flutter/material.dart';

class InputLogin extends StatelessWidget {
  const InputLogin({
    super.key,
    required this.color,
    required this.isSecured,
    required this.title,
    required this.onSaved,
    required this.onValidator,
  });
  final MyColor color;
  final bool isSecured;
  final String title;
  final void Function(String?) onSaved;
  final String? Function(String?) onValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecured,
      style: TextStyle(
        color: color.whColor,
      ),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(
          color: color.whColor.withAlpha(180),
        ),
        errorStyle: TextStyle(color: color.whColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: color.whColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 2,
            color: color.whColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: color.whColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: color.whColor,
          ),
        ),
      ),
      onSaved: onSaved,
      validator: onValidator,
    );
  }
}
