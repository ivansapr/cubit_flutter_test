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

  @override
  void initState() {
    final repository = RepositoryProvider.of<Repository>(context);
    cubit = TestCubit(repository);
    super.initState();
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
            return Center(child: CircularProgressIndicator());
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
    );
  }
}
