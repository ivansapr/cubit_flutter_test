class Repository {
  List<Function> _listeners = [];

  Future<void> addListener(Function(List<int> data) listener) async {
    _listeners.add(listener);
  }

  Future<void> _dispatch(List<int> data) async {
    _listeners.forEach((listener) {
      listener.call(data);
    });
  }

  Future<void> loadData() async {
    final data = List.generate(10, (index) => index);
    await Future.delayed(Duration(seconds: 3));
    _dispatch(data);
  }
}
