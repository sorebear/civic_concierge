import 'package:flutter/material.dart';

class ThemedButton extends StatelessWidget {
  final Function action;
  final String text;

  ThemedButton({this.action, this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        child: Text(
          this.text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: this.action,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36.0),
      ),
      color: Theme.of(context).accentColor,
    );
  }
}