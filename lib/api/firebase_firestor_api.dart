import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreApi {
  static Future<List<Object?>> getCollection(String myColleciton) async {
    var otherRef = FirebaseFirestore.instance.collection(myColleciton);
    QuerySnapshot querySnapshot = await otherRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  static Future<Map<String, dynamic>?> getDocument(String collection, String id)async{
    var otherRef = FirebaseFirestore.instance.collection(collection).doc(id);
    DocumentSnapshot<Map<String, dynamic>> querry = await otherRef.get();

    return querry.data();
  }

  static Future<void> addData(
      String collection, Map<String, dynamic> data) async {
    final reference = FirebaseFirestore.instance.collection(collection);
    reference.add(data);
  }

  static Future<void> setData(
      String collection, String id,Map<String, dynamic> data) async {
    final reference = FirebaseFirestore.instance.collection(collection);
    reference.doc(id).set(data);
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

  static Future<void> deleteDocument(String path, String id) async {
    var ref = FirebaseFirestore.instance.collection(path).doc(id);
    ref.delete();
  }

}
