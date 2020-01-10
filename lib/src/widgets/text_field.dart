import 'package:flutter/material.dart';

class ThemedTextField extends StatelessWidget {
  final Function onChanged;
  final bool obscureText;
  final String label;
  final int minLines;

  ThemedTextField(
      {this.onChanged,
      this.obscureText = false,
      this.label,
      this.minLines = 1});

  _borderOutline(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(27),
      gapPadding: 10,
      borderSide: BorderSide(
        color: color,
        width: 3.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 4.0),
            width: MediaQuery.of(context).size.width - 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.start,
            ),
          ),
          TextField(
            obscureText: obscureText,
            minLines: minLines,
            maxLines: minLines + 2,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
              enabledBorder: _borderOutline(Colors.white),
              focusedBorder: _borderOutline(Theme.of(context).accentColor),
            ),
            style: TextStyle(fontSize: 24, color: Colors.white),
            onChanged: onChanged,
          ),
          SizedBox(height: 24.0)
        ],
      ),
    );
  }
}
