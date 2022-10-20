import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:malu/models/models.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class FirebaseFirestoreService {
  CollectionReference vendors = db.collection('vendor');
  CollectionReference users = db.collection('users');
  CollectionReference foods = db.collection('food');

  Future<QuerySnapshot> getCollection(String name) async {
    return db.collection(name).get();
  }

  Future<User> getUser(User user) async {
    return users.doc(user.id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('nakapasok na rin sa wakas.');
        print(documentSnapshot.data());
        return User(
          id: user.id,
          email: user.email,
          photo: user.photo,
          name: user.name,
          balance: documentSnapshot['balance'],
          //favoriteVendor: documentSnapshot['favoriteVendor'],
          //mealPlanList: await getListOfMealPlan(),
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

  Future<Food> getFood(String id) async {
    return foods.doc(id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return Food.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return const Food(id: '', name: '', price: 0);
      }
    });
  }

  Future<List<Food>> getListOfFoods() async {
    return foods.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Food.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      /* querySnapshot.docs.forEach((doc) {
        print(doc["first_name"]);
      }); */
    });
  }

  Future<List<MealPlan>> getListOfMealPlan(String id) async {
    if (await doesSubCollectionExist(
        rootCollectionName: 'users',
        subCollectionName: 'mealPlan',
        rootCollectionDocId: id)) {
      return users
          .doc(id)
          .collection('mealPlan')
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return MealPlan.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
        /* querySnapshot.docs.forEach((doc) {
        print(doc["first_name"]);
      }); */
      });
    } else {
      return [];
    }
  }

  Future<void> insertMealPlan(User user, MealPlan mealPlan) async {
    users
        .doc(user.id)
        .collection('mealPlan')
        .withConverter(
          fromFirestore: MealPlan.fromFirestore,
          toFirestore: (MealPlan mealPlan, options) => mealPlan.toJson(),
        )
        .doc(mealPlan.date)
        .set(mealPlan);
  }

  Future<bool> doesSubCollectionExist(
      {required String rootCollectionName,
      required String subCollectionName,
      required String rootCollectionDocId}) {
    return db
        .collection(rootCollectionName)
        .doc(rootCollectionDocId)
        .collection(subCollectionName)
        .limit(1)
        .get()
        .then((value) {
      return value.docs.isNotEmpty;
    });
  }

  Stream<QuerySnapshot> getStreamOfCollection(String name) {
    return db.collection(name).snapshots();
  }
}
