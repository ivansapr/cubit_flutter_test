import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubit_example/repository/repository.dart';
import 'package:cubit_example/repository/stream_repository.dart';
import 'package:meta/meta.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit(this.repository, this.streamRepository) : super(TestInitial()) {
    repository.addListener((data) => _listener);
    streamRepository.listen(_listener);
  }

  void _listener(List<int> data) {
    emit(TestLoaded(data));
  }

  final Repository repository;
  final StreamRepository streamRepository;

  Future<void> load() async {
    emit(TestLoading());
    streamRepository.loadData();
  }
}
