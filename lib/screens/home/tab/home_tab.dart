import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ScrollController _controller = ScrollController();

  List questionGroups = [
    'VĂN HÓA',
    'SỨC KHỎE',
    'LỊCH SỬ',
    'TỰ NHIÊN',
    'THỂ THAO',
    'CÔNG NGHỆ'
  ];
  List imageNames = [
    'culture.jpg',
    'health.jpg',
    'history.jpg',
    'nature.jpg',
    'sport.jpg',
    'technology.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background/background.png'),
                  fit: BoxFit.cover)),
          child: Column(children: <Widget>[
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child: Text(
                'Q',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Quân Võ Trần Minh',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
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
        Column(children: <Widget>[
          Row(
            children: <Widget>[
              createQuestionGroup('VĂN HÓA', 'culture.jpg', 1),
              createQuestionGroup('SỨC KHỎE', 'health.jpg', 2),
            ],
          ),
          Row(
            children: <Widget>[
              createQuestionGroup('LỊCH SỬ', 'history.jpg', 1),
              createQuestionGroup('TỰ NHIÊN', 'nature.jpg', 2),
            ],
          ),
          Row(
            children: <Widget>[
              createQuestionGroup('THỂ THAO', 'sport.jpg', 1),
              createQuestionGroup('CÔNG NGHỆ', 'technology.jpg', 2),
            ],
          )
        ])
      ],
    );
  }

  Widget createQuestionGroup(
      String groupName, String imageName, int orderOnRow) {
    EdgeInsets edgeInsets;
    if (orderOnRow == 1) {
      edgeInsets = const EdgeInsets.fromLTRB(12, 12, 0, 0);
    } else {
      edgeInsets = const EdgeInsets.fromLTRB(9, 12, 0, 0);
    }

    return Padding(
      padding: edgeInsets,
      child: FractionalTranslation(
        translation: const Offset(0, 0),
        child: Container(
          width: 190,
          height: 110,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/question_group/$imageName'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              groupName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
