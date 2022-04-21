import 'package:flutter/material.dart';
import 'package:smarter/models/question/question_response.dart';
import 'package:smarter/services/question_service.dart';

class RandomQuestion extends StatefulWidget {
  final Future<QuestionResponse> getNextQuestion;
  const RandomQuestion({Key? key, required this.getNextQuestion})
      : super(key: key);

  @override
  State<RandomQuestion> createState() => _RandomQuestionState();
}

class _RandomQuestionState extends State<RandomQuestion> {
  final QuestionService _questionService = const QuestionService();
  bool _hasAnswered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuestionResponse>(
        future: widget.getNextQuestion,
        builder: (context, snapshot) => !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Builder(builder: (context) {
                final question = snapshot.data;
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildQuestion(question!),
                            if (_hasAnswered) _buildInfo(question),
                          ],
                        ),
                      ),
                    ),
                    _buildButtons(),
                  ],
                );
              }),
      ),
    );
  }

  Widget _buildQuestion(QuestionResponse question) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      width: 380,
      child: Column(
        children: [
          Container(
              height: 180,
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
              decoration: BoxDecoration(
                  image: question.imageUrl != ""
                      ? DecorationImage(
                          image: NetworkImage(question.imageUrl!),
                          fit: BoxFit.cover)
                      : const DecorationImage(
                          image: AssetImage(
                              'assets/question/default_question_image.png')))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              question.content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          Column(
            children: [
              _buildAnswer(question.answerA, "A", question.id),
              _buildAnswer(question.answerB, "B", question.id),
              if (question.answerC != "")
                _buildAnswer(question.answerC!, "C", question.id),
              if (question.answerD != "")
                _buildAnswer(question.answerD!, "D", question.id)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswer(String answerContent, String answerCode, int questionId) {
    bool isCorrect = false;
    bool isChosen = false;
    return InkWell(
      onTap: () {
        isCorrect = _isAnswerCorrect(answerCode, questionId);
        isChosen = true;
        setState(() {
          _hasAnswered = true;
        });
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          width: 380,
          decoration: BoxDecoration(
              color: _hasAnswered
                  ? isCorrect
                      ? Colors.green
                      : Colors.red
                  : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            answerContent,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          )),
    );
  }

  Widget _buildInfo(QuestionResponse question) {
    return SizedBox(
        width: 380,
        child: Text(
          question.information,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ));
  }

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 40), primary: Colors.green),
          label: const Text(
            "Trang chủ",
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_right_sharp),
          onPressed: () {
            print("A");
            setState(() {});
          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(100, 40)),
          label: const Text("Tiếp theo",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center),
        )
      ]),
    );
  }

  bool _isAnswerCorrect(String answerCode, int questionId) {
    bool result = false;
    _questionService.checkAnswer(questionId, answerCode).then((value) => {
          if (value.answerCorrect) {result = true}
        });
    return result;
  }
}
