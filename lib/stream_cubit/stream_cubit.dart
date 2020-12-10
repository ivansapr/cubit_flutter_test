import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubit_example/repository/stream_repository.dart';
import 'package:meta/meta.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamCubitState> {
  StreamSubscription subscription;
  StreamCubit(this.streamRepository) : super(StreamCubitInitial()) {
    subscription = streamRepository.listen(_listener);
  }
  final StreamRepository streamRepository;

  void _listener(List<int> data) {
    emit(StreamCubitLoaded(data));
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }

  Future<void> load() async {
    emit(StreamCubitLoading());
    streamRepository.loadData();
  }
}
