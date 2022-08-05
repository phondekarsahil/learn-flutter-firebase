import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';

class DatabaseService {
  final String uid;
  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  DatabaseService({this.uid = ''});

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name'),
          strength: doc.get('strength'),
          sugars: doc.get('sugars'));
    }).toList();
  }

  // get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
