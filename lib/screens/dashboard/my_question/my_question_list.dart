import 'package:flutter/material.dart';
import 'package:smarter/models/user_question/user_question_response.dart';
import 'package:smarter/screens/dashboard/my_question/add_question.dart';
import 'package:smarter/screens/dashboard/my_question/my_question_card.dart';
import 'package:smarter/services/user_question_service.dart';

class MyQuestionList extends StatefulWidget {
  const MyQuestionList({Key? key}) : super(key: key);

  @override
  State<MyQuestionList> createState() => _MyQuestionListState();
}

class _MyQuestionListState extends State<MyQuestionList> {
  final UserQuestionService _userQuestionService = const UserQuestionService();
  Future<dynamic>? _futureUserQuestionResponse;

  @override
  void initState() {
    super.initState();
    _futureUserQuestionResponse =
        _userQuestionService.getUserQuestionsForUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Câu hỏi của bạn"),
      ),
      backgroundColor: Colors.grey.shade400,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddQuestion()));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<dynamic>(
        future: _futureUserQuestionResponse,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data is bool) {
            return const Scaffold(
              body: Center(child: Text("Bạn chưa có câu hỏi nào!")),
            );
          }
          List<UserQuestionResponse> data = snapshot.data;
          return RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return MyQuestionCard(
                    userQuestionResponse: data[index],
                  );
                }),
          );
        },
      ),
    );
  }

  Future<void> _pullRefresh() async {
    dynamic freshFutureList =
        await _userQuestionService.getUserQuestionsForUser();
    setState(() {
      _futureUserQuestionResponse = Future.value(freshFutureList);
    });
  }
}
