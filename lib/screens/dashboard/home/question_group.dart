import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/question_list/question_list.dart';

class QuestionGroup extends StatelessWidget {
  final String groupName;
  final String imageName;
  final int groupId;

  const QuestionGroup(this.groupName, this.imageName, this.groupId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionList(
                            title: groupName,
                            groupId: groupId,
                          )))
            },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/question_group/$imageName'),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              groupName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
