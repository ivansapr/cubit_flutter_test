import 'package:cubit_example/repository/repository.dart';
import 'package:cubit_example/repository/stream_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository_page.dart';
import 'stream_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void onTap(context) {
    RepositoryProvider.of<Repository>(context).loadData();
    RepositoryProvider.of<StreamRepository>(context).loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [Tab(text: 'Observers'), Tab(text: 'Stream')]),
        ),
        body: TabBarView(
          children: [
            RepositoryPage(),
            StreamPage(),
          ],
        ),
      ),
    );
  }
}
