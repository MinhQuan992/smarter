import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/home/home_tab.dart';
import 'package:smarter/screens/dashboard/my_question/my_question_list.dart';
import 'package:smarter/screens/dashboard/question_list/question_list.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: _createMenu(),
            body: const TabBarView(children: [
              HomeTab(),
              QuestionList(title: "Câu hỏi yêu thích"),
              MyQuestionList(),
              Icon(Icons.account_box)
            ]),
          )),
    );
  }

  Widget _createMenu() {
    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]),
        child: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorWeight: 5,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.favorite_sharp),
              ),
              Tab(
                icon: Icon(Icons.list_alt_sharp),
              ),
              Tab(
                icon: Icon(Icons.account_box),
              )
            ]));
  }
}
