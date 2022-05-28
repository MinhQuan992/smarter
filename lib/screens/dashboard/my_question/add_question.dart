import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smarter/models/question/question_response.dart';
import 'package:smarter/models/question/user_question_request.dart';
import 'package:smarter/services/question_service.dart';
import 'package:smarter/services/storage_service.dart';

class AddQuestion extends StatefulWidget {
  final QuestionResponse? question;

  const AddQuestion({this.question, Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final StorageService _storageService = StorageService();
  final QuestionService _questionService = const QuestionService();
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  QuestionResponse? _question;
  String? _imageUrl,
      _content,
      _answerA,
      _answerB,
      _answerC,
      _answerD,
      _correctAnswer,
      _information;

  @override
  Widget build(BuildContext context) {
    if (widget.question != null) {
      _question = widget.question;
      _imageUrl ??= _question!.imageUrl;
      _content = _question!.content;
      _answerA = _question!.answerA;
      _answerB = _question!.answerB;
      _answerC = _question!.answerC;
      _answerD = _question!.answerD;
      _correctAnswer ??= _question!.correctAnswer;
      _information = _question!.information;
    } else {
      _correctAnswer ??= "ANSWER_A";
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _question != null
            ? const Text("Chỉnh sửa câu hỏi")
            : const Text("Thêm câu hỏi"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _globalFormKey,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final results = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg', 'jpeg']);
                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Bạn không chọn ảnh nào!")));
                    return;
                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;
                  await _storageService.uploadFile(path, fileName);
                  final newUrl = await _storageService.downloadUrl(fileName);
                  setState(() {
                    _imageUrl = newUrl;
                  });
                },
                child: SizedBox(
                    width: 380,
                    height: 200,
                    child: _imageUrl != null && _imageUrl != ""
                        ? Image.network(
                            _imageUrl!,
                          )
                        : Image.asset(
                            'assets/question/default_question_image.png',
                          )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 350,
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  initialValue: _content,
                  validator: (input) => input!.isEmpty || input.trim().isEmpty
                      ? "Mời bạn nhập nội dung câu hỏi"
                      : null,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nội dung câu hỏi"),
                  onSaved: (input) => _content = input!.trim(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Spacer(),
                  _buildCorrectIcon("A", _correctAnswer),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 280,
                    child: TextFormField(
                      initialValue: _answerA,
                      validator: (input) =>
                          input!.isEmpty || input.trim().isEmpty
                              ? "Mời bạn nhập đáp án A"
                              : null,
                      decoration: const InputDecoration(hintText: "Đáp án A"),
                      onSaved: (input) => _answerA = input!.trim(),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  _buildCorrectIcon("B", _correctAnswer),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 280,
                    child: TextFormField(
                      initialValue: _answerB,
                      validator: (input) =>
                          input!.isEmpty || input.trim().isEmpty
                              ? "Mời bạn nhập đáp án B"
                              : null,
                      decoration: const InputDecoration(hintText: "Đáp án B"),
                      onSaved: (input) => _answerB = input!.trim(),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  _buildCorrectIcon("C", _correctAnswer),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 280,
                    child: TextFormField(
                      initialValue: _answerC,
                      validator: (input) =>
                          input!.isEmpty || input.trim().isEmpty
                              ? "Mời bạn nhập đáp án C"
                              : null,
                      decoration: const InputDecoration(hintText: "Đáp án C"),
                      onSaved: (input) => _answerC = input!.trim(),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  _buildCorrectIcon("D", _correctAnswer),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 280,
                    child: TextFormField(
                      initialValue: _answerD,
                      validator: (input) =>
                          input!.isEmpty || input.trim().isEmpty
                              ? "Mời bạn nhập đáp án D"
                              : null,
                      decoration: const InputDecoration(hintText: "Đáp án D"),
                      onSaved: (input) => _answerD = input!.trim(),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 350,
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  initialValue: _information,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Thông tin bổ sung"),
                  onSaved: (input) => _information = input!.trim(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  _saveQuestion();
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(330, 50))),
                child: const Text(
                  "Lưu câu hỏi",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorrectIcon(String answerCode, String? correctAnswer) {
    return InkWell(
      onTap: () {
        setState(() {
          _correctAnswer = "ANSWER_" + answerCode;
        });
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: _setGreenWithIcon(answerCode, correctAnswer)
                ? Colors.green
                : Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  bool _setGreenWithIcon(String answerCode, String? correctAnswer) {
    if (correctAnswer != null && answerCode == correctAnswer.substring(7)) {
      return true;
    }
    return false;
  }

  bool _validateAndSave() {
    final form = _globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _saveQuestion() async {
    if (_validateAndSave()) {
      UserQuestionRequest userQuestionRequest = UserQuestionRequest(
          content: _content!,
          answerA: _answerA!,
          answerB: _answerB!,
          answerC: _answerC!,
          answerD: _answerD!,
          correctAnswer: _correctAnswer!.substring(7),
          imageUrl: _imageUrl,
          information: _information);
      if (widget.question == null) {
        await _questionService.addUserQuestion(userQuestionRequest);
      } else {
        await _questionService.updateUserQuestion(
            _question!.id, userQuestionRequest);
      }
      Navigator.pop(context);
    }
  }
}
