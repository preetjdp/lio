import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final DocumentReference ref;
  final String name;
  final Timestamp created;

  Room({this.ref, this.name, this.created});

  factory Room.fromFirestore(DocumentSnapshot _doc) {
    Map _data = _doc.data;
    return Room(
      ref: _doc.reference,
      name: _data['name'],
      created: _data['created'],
    );
  }
}
