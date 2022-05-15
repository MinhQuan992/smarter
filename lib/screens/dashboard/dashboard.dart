import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/home/home_tab.dart';
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
              Icon(Icons.list_alt_sharp),
              Icon(Icons.account_box)
            ]),
          )),
    );
  }

  Widget _createMenu() {
    return Container(
        color: Colors.blue,
        child: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
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
