import 'package:flutter/material.dart';
import 'package:smarter/models/user_question/user_question_response.dart';
import 'package:smarter/screens/dashboard/question_list/question_card.dart';
import 'package:smarter/services/user_question_service.dart';

class QuestionList extends StatefulWidget {
  final int? groupId;
  final String title;
  const QuestionList({required this.title, this.groupId, Key? key})
      : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final UserQuestionService _userQuestionService = const UserQuestionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.grey.shade400,
        body: FutureBuilder<dynamic>(
          future: widget.groupId == null
              ? _userQuestionService.getFavoriteQuestionsForUser()
              : _userQuestionService
                  .getQuestionsByGroupForUser(widget.groupId!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data is bool) {
              return const Scaffold(
                body: Center(child: Text("Bạn chưa có câu hỏi yêu thích nào!")),
              );
            }
            List<UserQuestionResponse> data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return QuestionCard(
                    userQuestionResponse: data[index],
                    fromFavoriteList: widget.groupId == null,
                  );
                });
          },
        ));
  }
}
