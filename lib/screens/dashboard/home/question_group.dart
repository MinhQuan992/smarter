import 'package:flutter/material.dart';

class QuestionGroup extends StatelessWidget {
  final String groupName;
  final String imageName;

  const QuestionGroup(this.groupName, this.imageName, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/question_group/$imageName'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Stack(children: <Widget>[
        Text(
          groupName,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = Colors.blue),
          textAlign: TextAlign.center,
        ),
        Text(
          groupName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
      ])),
    );
  }
}
