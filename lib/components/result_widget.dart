import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  
  final bool win;
  final Function onRestart;

  ResultWidget({
    @required this.win,
    @required this.onRestart,
  });

  Color _getColor() {
    if (win == null) {
      return Colors.yellow[300];
    } else if (win){
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  IconData _getIcon() {
    if (win == null) {
      return Icons.sentiment_neutral;
    } else if (win){
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: CircleAvatar(
          backgroundColor: _getColor(),
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              _getIcon(),
              color: Colors.black,
              size: 40,
            ),
            onPressed: onRestart,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}