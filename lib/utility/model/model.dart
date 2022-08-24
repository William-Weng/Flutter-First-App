class Model {
  final String key;
  final List<dynamic> value;

  const Model({required this.key, required this.value});

  // https://www.jianshu.com/p/46b1408f3a79
  factory Model.fromJSON(Map<String, dynamic> json) {
    final key = json['key'] as String;
    final value = json['value'] as List<dynamic>;

    final record = Model(key: key, value: value);

    return record;
  }

  static List<Model> fromList(List<dynamic> jsonList) {
    List<Model> list = [];

    for (var json in jsonList) {
      final model = Model.fromJSON(json);
      list.add(model);
    }

    return list;
  }
}
