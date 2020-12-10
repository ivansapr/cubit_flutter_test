import 'dart:async';

import 'package:rxdart/subjects.dart';

class StreamRepository {
  BehaviorSubject<List<int>> _stream = BehaviorSubject<List<int>>();

  void close() {
    _stream.close();
  }

  StreamSubscription<List<int>> listen(void Function(List<int> data) listener) {
    return _stream.stream.listen(listener);
  }

  Future<void> loadData() async {
    final data = List.generate(10, (index) => 10 - index);
    await Future.delayed(Duration(seconds: 3));
    _stream.add(data);
  }
}
