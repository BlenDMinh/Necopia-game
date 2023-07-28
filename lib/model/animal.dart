import 'package:necopia/model/entity.dart';

class Animal implements Entity {
  @override
  String id;
  String name;

  Animal(this.name) : id = '#';

  Animal.fromJson(this.id, Map<String, dynamic> json) : name = json['name'];

  @override
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
