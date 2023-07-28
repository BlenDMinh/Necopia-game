import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:necopia/model/animal.dart';
import 'package:necopia/service/crud_service.dart';

abstract class IAnimalSerivce extends ICrudService<Animal> {}

class AnimalService extends CrudService<Animal> implements IAnimalSerivce {
  AnimalService()
      : super(FirebaseFirestore.instance
            .collection('animal')
            .withConverter<Animal>(
                fromFirestore: (snapshot, _) =>
                    Animal.fromJson(snapshot.id, snapshot.data()!),
                toFirestore: (animal, _) => animal.toJson()));
}
