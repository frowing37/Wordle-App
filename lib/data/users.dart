import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore koleksiyon referansı oluşturma
class UserDB {

final CollectionReference usersCollection = FirebaseFirestore.instance.collection("User");

// Yeni bir kullanıcı ekleme
Future<void> addUser(String username, String email, String password) async {
  return usersCollection
      .add({'username': username, 'mail': email, 'password': password})
      .then((value) => print("Kullanıcı eklendi"))
      .catchError((error) => print("Hata: $error"));
}

// Kullanıcıları getirme
Stream<QuerySnapshot> getUsers() {
  return usersCollection.snapshots();
}

// E-posta adresine göre kullanıcıyı arama
  Future<QuerySnapshot> searchUserByEmail(String email) {
    return usersCollection.where('mail', isEqualTo: email).get();
  }

// Kullanıcıyı güncelleme
Future<void> updateUser(String id, String newName, String newEmail) {
  return usersCollection
      .doc(id)
      .update({'name': newName, 'email': newEmail})
      .then((value) => print("Kullanıcı güncellendi"))
      .catchError((error) => print("Hata: $error"));
}

// Kullanıcıyı silme
Future<void> deleteUser(String id) {
  return usersCollection
      .doc(id)
      .delete()
      .then((value) => print("Kullanıcı silindi"))
      .catchError((error) => print("Hata: $error"));
}

}
