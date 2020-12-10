class Repository {
  List<void Function(List<int> data)> _listeners = [];

  Future<void> addListener(void Function(List<int> data) listener) async {
    _listeners.add(listener);
  }

  Future<void> _dispatch(List<int> data) async {
    _listeners.forEach((listener) {
      listener(data);
    });
  }

  Future<void> loadData() async {
    final data = List.generate(10, (index) => index);
    await Future.delayed(Duration(seconds: 3));
    await _dispatch(data);
  }
}
