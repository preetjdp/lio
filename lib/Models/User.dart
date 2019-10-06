import 'package:cloud_firestore/cloud_firestore.dart';

String globalUserId = 'nbPEEP53YEhLnCoUFlwZ';

class User {
  DocumentReference documentReference;
   String name;
  Timestamp created;

  User({
    this.documentReference,
    this.name,
    this.created
  });

  factory User.fromFirestore(DocumentSnapshot _doc) {
    Map _data = _doc.data;
    return User(
      documentReference: _doc.reference,
      name: _data['name'],
      created: _data['created']
    );
  }
}