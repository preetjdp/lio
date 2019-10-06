import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lio/Models/Room.dart';
import 'package:lio/Models/User.dart';

// final DocumentReference userDb =
//     Firestore.instance.document('users/$globalUserId');

class DatabaseService {
  Stream<List<Room>> streamRooms() {
    CollectionReference _ref = Firestore.instance.collection('rooms');

    return _ref.snapshots().map((list) => list.documents.map((doc) {
          return Room.fromFirestore(doc);
        }));
  }

  Stream<User> streamCurrentUser() {
    CollectionReference _ref = Firestore.instance.collection('users');
    return _ref
        .document(globalUserId)
        .snapshots()
        .map((user) => User.fromFirestore(user));
  }
}
