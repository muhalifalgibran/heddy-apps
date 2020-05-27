import 'package:fit_app/core/blocs/scroll_fragment_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String data);

class FormUtils1 {
  static OutlineButton buildField(
    String label, {
    String value,
    String suffix,
    String hint,
    bool isEnabled = true,
    bool obscureText = false,
    FocusNode focusNode,
    StringCallback onChanged,
    String errorText,
    TextInputType inputType,
    Icon beforeIcon,
    Icon prefixIcon,
    Icon suffixIcon,
    TextEditingController controller,
    Null Function() onPressed,
  }) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.white),
      color: Colors.white,
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      padding: EdgeInsets.fromLTRB(35.0, 8.0, 35.0, 8.0),
      splashColor: Colors.blueAccent,
      onPressed: onPressed,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0),
        ),
      ]),
    );
  }
}
