import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/home/question_group.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List groupNames = [
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
              padding: const EdgeInsets.symmetric(vertical: 13),
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
        Expanded(
          child: GridView.count(
            childAspectRatio: 1.75,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            children: <Widget>[
              QuestionGroup(groupNames[0], imageNames[0]),
              QuestionGroup(groupNames[1], imageNames[1]),
              QuestionGroup(groupNames[2], imageNames[2]),
              QuestionGroup(groupNames[3], imageNames[3]),
              QuestionGroup(groupNames[4], imageNames[4]),
              QuestionGroup(groupNames[5], imageNames[5]),
            ],
          ),
        ),
      ],
    );
  }
}
