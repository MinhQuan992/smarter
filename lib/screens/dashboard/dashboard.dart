import 'package:flutter/material.dart';
import 'package:smarter/screens/dashboard/home/home_tab.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: createMenu(),
            body: const TabBarView(children: [
              HomeTab(),
              Icon(Icons.save),
              Icon(Icons.account_box)
            ]),
          )),
    );
  }

  Widget createMenu() {
    return Container(
        color: Colors.blue,
        child: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: 'Trang chủ',
                icon: Icon(Icons.home),
              ),
              Tab(
                text: 'Câu hỏi đã lưu',
                icon: Icon(Icons.save),
              ),
              Tab(
                text: 'Tài khoản',
                icon: Icon(Icons.account_box),
              )
            ]));
  }
}
