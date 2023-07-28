import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:necopia/model/entity.dart';

abstract class ICrudService<T extends Entity> {
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<T> add(T data);
  Future<T> update(T data);
  Future<T> delete(T data);
}

class CrudService<T extends Entity> implements ICrudService<T> {
  CollectionReference<T> dataRef;
  CrudService(this.dataRef);

  @override
  Future<List<T>> getAll() async {
    return dataRef
        .get()
        .then((snapshots) => snapshots.docs.map((e) => e.data()).toList());
  }

  @override
  Future<T?> getById(String id) async {
    return dataRef.doc(id).get().then((snapshot) => snapshot.data());
  }

  @override
  Future<T> add(T data) async {
    final docRef = await dataRef.add(data);
    final newData = await docRef.get();
    return newData.data()!;
  }

  @override
  Future<T> update(T data) async {
    dataRef.doc(data.id).update(data.toJson());
    return data;
  }

  @override
  Future<T> delete(T data) async {
    dataRef.doc(data.id).delete();
    return data;
  }
}
