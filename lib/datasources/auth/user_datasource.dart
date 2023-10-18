import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';
import 'package:reaya_shared_code/models/auth/user_model.dart';

class UserDatasource {
  Future<UserModel?> getUserById(String? id) async {
    if (id == null) return null;
    var doc = (await FirebaseFirestore.instance
            .collection(Collections.users)
            .doc(id)
            .get())
        .data();
    if (doc == null) return null;
    var model = UserModel.fromJson(doc);
    return model;
  }

  Future<UserModel?> getLoggedInUserInfo() async {
    String? id = firebaseAuth.currentUser?.uid;
    return getUserById(id);
  }

  Future<void> saveUserModel(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(userModel.id)
        .set(userModel.toJson());
  }
}
