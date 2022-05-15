import 'package:flutter/material.dart';
import 'package:smarter/models/question/question_response.dart';
import 'package:smarter/services/question_service.dart';

class Question extends StatefulWidget {
  final Future<QuestionResponse> Function()? getNextQuestion;
  final Future<QuestionResponse> Function(int, bool)?
      getNextQuestionInGroupOrFavoriteList;
  final int? currentQuestionId;
  const Question(
      {Key? key,
      this.getNextQuestion,
      this.getNextQuestionInGroupOrFavoriteList,
      this.currentQuestionId})
      : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final QuestionService _questionService = const QuestionService();

  bool _wasInit = false;
  bool _hasAnswered = false;
  String _chosenAnswer = "";
  int _numberOfRebuildAttempts = 0;
  QuestionResponse? _response;
  Future<QuestionResponse>? _getNextQuestion;
  int? _currentQuestionId;

  @override
  Widget build(BuildContext context) {
    if (_wasInit == false) {
      if (widget.getNextQuestion != null) {
        _getNextQuestion = widget.getNextQuestion!();
      } else {
        _getNextQuestion = widget.getNextQuestionInGroupOrFavoriteList!(
            widget.currentQuestionId!, true);
        _currentQuestionId = widget.currentQuestionId!;
      }
      _wasInit = true;
    }

    return Scaffold(
      body: FutureBuilder<QuestionResponse>(
        future: _getNextQuestion,
        builder: (context, snapshot) => !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Builder(builder: (context) {
                final question = _response ?? snapshot.data;
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
                  image: question.imageUrl == ""
                      ? const DecorationImage(
                          image: AssetImage(
                              'assets/question/default_question_image.png'))
                      : DecorationImage(
                          image: NetworkImage(question.imageUrl!),
                          fit: BoxFit.cover))),
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
              _buildAnswer(question, "A"),
              _buildAnswer(question, "B"),
              if (question.answerC != "") _buildAnswer(question, "C"),
              if (question.answerD != "") _buildAnswer(question, "D")
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswer(QuestionResponse question, String answerCode) {
    return InkWell(
      onTap: () async {
        await _questionService.checkAnswer(question.id, answerCode);
        setState(() {
          _chosenAnswer = answerCode;
          _hasAnswered = true;
        });
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          width: 380,
          decoration: BoxDecoration(
              color: _hasAnswered
                  ? _getColor(question, answerCode, _chosenAnswer)
                  : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            _getAnswerContent(question, answerCode),
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
          onPressed: () async {
            _numberOfRebuildAttempts += 1;
            _hasAnswered = false;
            await getNextQuestion();
          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(100, 40)),
          label: const Text("Tiếp theo",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center),
        )
      ]),
    );
  }

  Color _getColor(
      QuestionResponse question, String answerCode, String chosenAnswer) {
    if (question.correctAnswer.substring(7) == answerCode) {
      return Colors.green;
    }
    if (chosenAnswer == answerCode) {
      return Colors.red;
    }
    return Colors.grey.shade400;
  }

  String _getAnswerContent(QuestionResponse question, String answerCode) {
    if (answerCode == "A") {
      return question.answerA;
    }
    if (answerCode == "B") {
      return question.answerB;
    }
    if (answerCode == "C") {
      return question.answerC!;
    }
    return question.answerD!;
  }

  Future<void> getNextQuestion() async {
    QuestionResponse response;
    if (widget.getNextQuestion != null) {
      response = await widget.getNextQuestion!();
    } else {
      response = await widget.getNextQuestionInGroupOrFavoriteList!(
          _currentQuestionId!, false);
    }
    setState(() {
      _response = response;
      _currentQuestionId = response.id;
    });
  }
}
