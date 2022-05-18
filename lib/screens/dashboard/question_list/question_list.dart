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
  Future<dynamic>? _futureUserQuestionResponse;

  @override
  void initState() {
    super.initState();
    if (widget.groupId == null) {
      _futureUserQuestionResponse =
          _userQuestionService.getFavoriteQuestionsForUser();
    } else {
      _futureUserQuestionResponse =
          _userQuestionService.getQuestionsByGroupForUser(widget.groupId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.grey.shade400,
        body: FutureBuilder<dynamic>(
          future: _futureUserQuestionResponse,
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
            return RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      userQuestionResponse: data[index],
                      fromFavoriteList: widget.groupId == null,
                    );
                  }),
            );
          },
        ));
  }

  Future<void> _pullRefresh() async {
    dynamic freshFutureList;
    if (widget.groupId == null) {
      freshFutureList =
          await _userQuestionService.getFavoriteQuestionsForUser();
    } else {
      freshFutureList = await _userQuestionService
          .getQuestionsByGroupForUser(widget.groupId!);
    }
    setState(() {
      _futureUserQuestionResponse = Future.value(freshFutureList);
    });
  }
}
