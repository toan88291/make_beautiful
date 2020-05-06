import 'package:flutter/material.dart';

class ButtonClickWidget extends StatelessWidget {
  final VoidCallback onPressed;

  final String title;

  ButtonClickWidget(this.title, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 12),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
            title,
            style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
        ),
      ),
    );
  }
}
