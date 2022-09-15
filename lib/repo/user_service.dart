import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangma/data/item_model.dart';
import 'package:dangma/data/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

import '../constraints/data_keys.dart';
import '../utils/logger.dart';

class UserService {
  static final UserService _userService = UserService._internal();

  factory UserService() => _userService;

  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      await documentReference.set(json);
    }
  }

  Future<UserModel> getUserModel(String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();
    UserModel userModel = UserModel.fromSnapshot(documentSnapshot);
    return userModel;
  }


}
