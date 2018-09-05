class GlobalState {
  final Map<dynamic, dynamic> _data = <dynamic, dynamic>{};

  // My comment...
  // GlobalState._();
  // A private constructor is a special generative constructor
  // that prevents a class from being explicitly instantiated by its callers.
  // It is usually used
  // in the following cases:
  // • For a singleton class ...
  // Book "Mastering Dart",  2014
  static GlobalState instance = GlobalState._();

  GlobalState._();

  set(dynamic key, dynamic value) => _data[key] = value;

  get(dynamic key) => _data[key];
}
