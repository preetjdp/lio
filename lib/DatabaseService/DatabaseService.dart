import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lio/Models/Room.dart';

// final DocumentReference userDb =
//     Firestore.instance.document('users/$globalUserId');

class DatabaseService {
  Stream<List<Room>> streamRooms() {
    CollectionReference _ref = Firestore.instance.collection('rooms');

    return _ref.snapshots().map((list) => list.documents.map((doc) {
          return Room.fromFirestore(doc);
        }));
  }
}
