import 'package:flutter/material.dart';
import 'package:smarter/models/user/user_response.dart';
import 'package:smarter/screens/dashboard/question/random_question.dart';
import 'package:smarter/screens/dashboard/home/question_group.dart';
import 'package:smarter/services/question_service.dart';
import 'package:smarter/services/user_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List _groupNames = [
    'VĂN HÓA',
    'SỨC KHỎE',
    'LỊCH SỬ',
    'TỰ NHIÊN',
    'THỂ THAO',
    'CÔNG NGHỆ'
  ];
  final List _imageNames = [
    'culture.jpg',
    'health.jpg',
    'history.jpg',
    'nature.jpg',
    'sport.jpg',
    'technology.jpg'
  ];

  final UserService _userService = const UserService();
  final QuestionService _questionService = const QuestionService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserResponse>(
        future: _userService.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final user = snapshot.data;
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/background.png'),
                          fit: BoxFit.cover)),
                  child: Column(children: <Widget>[
                    // TODO: check the avatar
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red,
                      child: Text(
                        _getTheFirstLetterOfName(user!.name),
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        user.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RandomQuestion(
                                        getNextQuestion: _questionService
                                            .getRandomQuestion(),
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50)),
                        child: const Text(
                          'Chơi ngẫu nhiên',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: GridView.count(
                    childAspectRatio: 1.75,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    children: <Widget>[
                      QuestionGroup(_groupNames[0], _imageNames[0]),
                      QuestionGroup(_groupNames[1], _imageNames[1]),
                      QuestionGroup(_groupNames[2], _imageNames[2]),
                      QuestionGroup(_groupNames[3], _imageNames[3]),
                      QuestionGroup(_groupNames[4], _imageNames[4]),
                      QuestionGroup(_groupNames[5], _imageNames[5]),
                    ],
                  ),
                ),
              ],
            );
          }
        });
  }

  String _getTheFirstLetterOfName(String name) {
    List<String> splittedName = name.split(" ");
    return splittedName[splittedName.length - 1][0];
  }
}
