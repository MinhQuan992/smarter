import 'package:flutter/material.dart';
import 'package:smarter/models/user_question/user_question_response.dart';
import 'package:smarter/screens/dashboard/my_question/add_question.dart';
import 'package:smarter/screens/dashboard/question/question.dart';
import 'package:smarter/services/question_service.dart';

class MyQuestionCard extends StatefulWidget {
  final UserQuestionResponse userQuestionResponse;
  const MyQuestionCard({required this.userQuestionResponse, Key? key})
      : super(key: key);

  @override
  State<MyQuestionCard> createState() => _MyQuestionCardState();
}

class _MyQuestionCardState extends State<MyQuestionCard> {
  final QuestionService _questionService = const QuestionService();

  @override
  Widget build(BuildContext context) {
    UserQuestionResponse question = widget.userQuestionResponse;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Question(
                      getNextQuestionInList:
                          _questionService.getNextUserQuestion,
                      currentQuestionId: widget.userQuestionResponse.questionId,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2.5)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: question.imageUrl != ""
                      ? DecorationImage(
                          image: NetworkImage(question.imageUrl!),
                          fit: BoxFit.cover)
                      : const DecorationImage(
                          image: AssetImage(
                              'assets/question/default_question_image.png')),
                  borderRadius: BorderRadius.circular(50)),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(question.shortContent,
                    style: const TextStyle(fontSize: 18))),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddQuestion()));
              },
              child: const Icon(
                Icons.edit,
                color: Colors.blue,
                size: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
