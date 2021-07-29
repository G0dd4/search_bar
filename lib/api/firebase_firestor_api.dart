import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreApi {
  final String collection;
  late var reference;

  static late List<Object?> myData;

  FirebaseFirestoreApi({
    required this.collection,
  }) {
    this.reference = FirebaseFirestore.instance.collection(this.collection);
  }

  static Future<List<Object?>> getCollection(String myColleciton) async {
    var otherRef = FirebaseFirestore.instance.collection(myColleciton);
    QuerySnapshot querySnapshot = await otherRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }
}
