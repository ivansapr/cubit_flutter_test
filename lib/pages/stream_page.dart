import 'package:cubit_example/repository/stream_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../stream_cubit/stream_cubit.dart';

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  StreamCubit cubit;

  @override
  void initState() {
    final repository = RepositoryProvider.of<StreamRepository>(context);
    cubit = StreamCubit(repository);
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
      body: BlocBuilder<StreamCubit, StreamCubitState>(
        cubit: cubit,
        builder: (context, state) {
          print(state);
          if (state is StreamCubitInitial) {
            return Center(
              child: Text('Initia?l'),
            );
          }
          if (state is StreamCubitLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is StreamCubitLoaded) {
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
