import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doeat/models/models.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class FirebaseFirestoreService {
  CollectionReference vendors = db.collection('vendor');
  CollectionReference users = db.collection('users');

  Future<QuerySnapshot> getCollection(String name) async {
    return db.collection(name).get();
  }

  Future<User> getUser(User user) async {
    return users.doc(user.id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('nakapasok na rin sa wakas.');
        print(documentSnapshot['favoriteVendor']);
        print(documentSnapshot.data());
        return User(
          id: user.id,
          email: user.email,
          photo: user.photo,
          name: user.name,
          balance: documentSnapshot['balance'],
          favoriteVendor: documentSnapshot['favoriteVendor'],
        );
        //return User.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        print('di nakuha ung users data.. hayst');
        return const User(id: '');
      }
    }).catchError((error, stackTrace) {
      print(error);
      return const User(id: '');
    });
  }

  Future<Vendor> getVendor(String id) async {
    return vendors.doc(id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return Vendor.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return const Vendor(id: '');
      }
    });
  }

  Future<List<Vendor>> getListOfVendors() async {
    return vendors.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Vendor.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      /* querySnapshot.docs.forEach((doc) {
        print(doc["first_name"]);
      }); */
    });
  }

  Stream<QuerySnapshot> getStreamOfCollection(String name) {
    return db.collection(name).snapshots();
  }
}
