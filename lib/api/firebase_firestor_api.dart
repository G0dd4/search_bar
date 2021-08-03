import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreApi {
  static Future<List<Object?>> getCollection(String myColleciton) async {
    var otherRef = FirebaseFirestore.instance.collection(myColleciton);
    QuerySnapshot querySnapshot = await otherRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  static Future<void> setData(
      String collection, Map<String, dynamic> data) async {
    final reference = FirebaseFirestore.instance.collection(collection);
    reference.add(data);
  }

  static Future<List<Object?>> getLastFromCollection(
      String myColleciton, String orderBy, int max) async {
    var ref = FirebaseFirestore.instance.collection(myColleciton);
    QuerySnapshot querySnapshot =
        await ref.orderBy(orderBy, descending: true).limitToLast(max).get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  static Future<List<Object?>> getDocWhenEqual(
      String myCollection, String field, String comparedData) async {
    var ref = FirebaseFirestore.instance.collection(myCollection);
    QuerySnapshot querySnapshot =
        await ref.where(field, isEqualTo: comparedData).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
