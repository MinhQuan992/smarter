import 'package:flutter/material.dart';
import 'package:smarter/models/question/question_response.dart';
import 'package:smarter/services/question_service.dart';

class Question extends StatefulWidget {
  final Future<QuestionResponse> Function()? getNextQuestion;
  final Future<QuestionResponse> Function(int, bool)?
      getNextQuestionInGroupOrFavoriteList;
  final int? currentQuestionId;
  final bool? isFavorite;
  const Question(
      {Key? key,
      this.getNextQuestion,
      this.getNextQuestionInGroupOrFavoriteList,
      this.currentQuestionId,
      this.isFavorite})
      : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final QuestionService _questionService = const QuestionService();

  bool _wasInit = false;
  bool _hasAnswered = false;
  String _chosenAnswer = "";
  QuestionResponse? _response;
  Future<QuestionResponse>? _getNextQuestion;
  int? _currentQuestionId;
  bool? _isFavorite;

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
      if (widget.isFavorite != null) {
        _isFavorite = widget.isFavorite!;
      }
      _wasInit = true;
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: FutureBuilder<QuestionResponse>(
        future: _getNextQuestion,
        builder: (context, snapshot) => !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Builder(builder: (context) {
                final question = _response ?? snapshot.data;
                _currentQuestionId = question!.id;
                _isFavorite ??= question.favorite;
                return Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 30, bottom: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox.fromSize(
                          size: const Size(30, 30),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Colors.green,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.close_sharp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildQuestion(question),
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
    return SizedBox(
      width: 380,
      child: Column(
        children: [
          if (question.imageUrl == "")
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/question/default_question_image.png',
              ),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                question.imageUrl!,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              question.content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
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
                : Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Text(
            _getAnswerContent(question, answerCode),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal),
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
      child: Row(children: [
        const Spacer(),
        if (_hasAnswered)
          InkWell(
            onTap: () async {
              await _questionService.setFavorite(
                  _currentQuestionId!, !_isFavorite!);
              setState(() {
                _isFavorite = !_isFavorite!;
              });
            },
            child: SizedBox(
                width: 80,
                height: 50,
                child: _isFavorite!
                    ? const Icon(
                        Icons.favorite_sharp,
                        color: Colors.red,
                        size: 35,
                      )
                    : const Icon(
                        Icons.favorite_border_sharp,
                        color: Colors.red,
                        size: 35,
                      )),
          ),
        InkWell(
          onTap: () async {
            _hasAnswered = false;
            await getNextQuestion();
          },
          child: Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(color: Colors.blue.shade300),
            child: Row(
              children: [
                const Expanded(
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const Expanded(
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.blue.shade300,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Color _getColor(
      QuestionResponse question, String answerCode, String chosenAnswer) {
    if (question.correctAnswer.substring(7) == answerCode) {
      return Color.fromARGB(255, 75, 210, 80);
    }
    if (chosenAnswer == answerCode) {
      return Colors.red;
    }
    return Colors.white;
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
      _isFavorite = response.favorite;
    });
  }
}
