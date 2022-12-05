abstract class Model {
  Model();

  Model copyWith();

  Map<String, dynamic> toMap();

  Model.fromMap(Map<String, dynamic> map);
}
