import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/home/question_group.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

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
}
