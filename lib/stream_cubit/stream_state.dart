part of 'stream_cubit.dart';

@immutable
abstract class StreamCubitState {}

class StreamCubitInitial extends StreamCubitState {}

class StreamCubitLoading extends StreamCubitState {}

class StreamCubitLoaded extends StreamCubitState {
  StreamCubitLoaded(this.data);
  final List<int> data;
}
