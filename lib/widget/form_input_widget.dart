import 'package:flutter/material.dart';

class FormInputWidget extends StatelessWidget {
  final String hintText;

  final FormFieldValidator<String> validator;

  final FormFieldSetter<String> onSaved;

  final bool obscureText;

  final bool readOnly;

  final Widget prefixIcon;

  final Widget suffixIcon;

  final ValueChanged<String> onChanged;

  final GestureTapCallback onTap;

  FormInputWidget(this.hintText,
      {this.validator,
      this.onSaved,
      this.obscureText,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minWidth: 48,
            minHeight: 24
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: Theme.of(context).textTheme.subtitle2.copyWith(
            color: Colors.grey
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
          prefixIcon: prefixIcon ?? null,
          suffixIcon: suffixIcon != null ? suffixIcon : null,
        ),
        readOnly: readOnly,
        cursorColor: Colors.grey,
        obscureText: obscureText ?? false,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
