import 'package:cubit_example/repository/repository.dart';
import 'package:cubit_example/repository/stream_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/test_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TestCubit cubit;

  @override
  void initState() {
    super.initState();

    final repository = Repository();
    final streamRepository = StreamRepository();

    cubit = TestCubit(repository, streamRepository);
  }

  void onTap() {
    cubit?.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<TestCubit, TestState>(
        cubit: cubit,
        builder: (context, state) {
          print(state);
          if (state is TestInitial) {
            return Center(
              child: Text('Initia?l'),
            );
          }
          if (state is TestLoading) {
            return CircularProgressIndicator();
          }

          if (state is TestLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Index $index'),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: state.data.length,
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTap,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
