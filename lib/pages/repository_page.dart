import 'dart:async';

import 'package:cubit_example/repository/repository.dart';

import '../cubit/test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryPage extends StatefulWidget {
  @override
  _RepositoryPageState createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  TestCubit cubit;

  final bonRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    final repository = RepositoryProvider.of<Repository>(context);
    cubit = TestCubit(repository);

    _refreshCompleter = Completer();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  void onTap(context) {
    cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTap(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: BlocConsumer<TestCubit, TestState>(
          listener: (context, state) {
            if (state is TestLoaded) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
            }
          },
          cubit: cubit,
          builder: (context, state) {
            print(state);
            if (state is TestInitial) {
              return Center(
                child: Text('Initia?l'),
              );
            }
            if (state is TestLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is TestLoaded) {
              return buildListView(state);
            }
            return Container();
          },
        ),
      ),
    );
  }

  ListView buildListView(TestLoaded state) {
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

  Future<void> onRefresh() async {
    cubit.onRefresh();
    return _refreshCompleter.future;
  }
}
