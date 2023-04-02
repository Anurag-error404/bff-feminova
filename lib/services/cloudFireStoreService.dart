import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;

  Future<DocumentReference> createFirestoreDoc(
      {required String collectionPath, required Map<String, dynamic> data, String? docId}) async {
    if (docId != null) {
      DocumentReference docRef = _firestore.collection(collectionPath).doc(docId);
      await docRef.set(data);
      return docRef;
    }
    return _firestore.collection(collectionPath).add(data);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchFirestoreDocs({
    required String collectionPath,
    String? queryParam,
    dynamic? value,
  }) async {
    if (queryParam == null) {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs;
    }
    final querySnapshot = await _firestore
        .collection(collectionPath)
        .where(
          queryParam,
          isEqualTo: value,
        )
        .get();
    return querySnapshot.docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenCollection({required String collectionPath}) {
    return _firestore.collection(collectionPath).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchFirestoreDoc(
      {required String collectionPath, required String docId}) async {
    final docSnapshot = await _firestore.collection(collectionPath).doc(docId).get();
    return docSnapshot;
  }

  Future<void> updateFirestoreDoc(
      {required String collection, required String docId, required Map<String, dynamic> data}) {
    return _firestore.collection(collection).doc(docId).update(data);
  }

  Future<bool> checkIfDocExists({
    required String collection,
    required String docId,
  }) async {
    final docSnapshot = await _firestore.collection(collection).doc(docId).get();
    return docSnapshot.exists;
  }

  Future<void> deleteFirestoreDoc({required String collection, required String docId}) {
    return _firestore.collection(collection).doc(docId).delete();
  }
}
