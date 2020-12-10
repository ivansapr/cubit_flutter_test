part of 'test_cubit.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestLoaded extends TestState {
  TestLoaded(this.data);
  final List<int> data;
}
