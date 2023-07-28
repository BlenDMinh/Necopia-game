import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:necopia/model/user.dart';
import 'package:necopia/service/crud_service.dart';

class UserService extends CrudService<NecopiaUser> {
  UserService()
      : super(FirebaseFirestore.instance
            .collection('user')
            .withConverter<NecopiaUser>(
                fromFirestore: (snapshot, _) =>
                    NecopiaUser.fromJson(snapshot.data()!),
                toFirestore: (user, _) => user.toJson()));

  Future<NecopiaUser?> getByUid(String uid) async {
    final snapshot = await dataRef.where('uid', isEqualTo: uid).get();
    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs[0].data();
  }

  @override
  Future<NecopiaUser> update(NecopiaUser user) {
    throw const Deprecated("Use updateNecopiaUser instead");
  }

  Future<NecopiaUser?> updateNecopiaUser(NecopiaUser user) async {
    final snapshot = await dataRef.where('uid', isEqualTo: user.uid).get();
    if (snapshot.docs.isEmpty) return null;
    snapshot.docs[0].reference.update(user.toJson());
    return user;
  }
}
