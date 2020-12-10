import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubit_example/repository/repository.dart';
import 'package:meta/meta.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit(this.repository) : super(TestInitial()) {
    repository.addListener(_listener);
  }

  final Repository repository;

  void _listener(List<int> data) {
    emit(TestLoaded(data));
  }

  Future<void> load() async {
    emit(TestLoading());
    repository.loadData();
  }
}
