import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';

class FCMTokensSource {
  Future<bool> saveMyToken(String token) async {
    String? userId = firebaseAuth.currentUser?.uid;
    if (userId == null) return false;
    await FirebaseFirestore.instance
        .collection(Collections.userFCMToken)
        .doc(userId)
        .set({
      'token': token,
    });
    return true;
  }

  Future<String?> getUserFcmToken(String userId) async {
    var doc = (await FirebaseFirestore.instance
            .collection(Collections.userFCMToken)
            .doc(userId)
            .get())
        .data();
    if (doc == null) return null;
    String? token = doc['token'];
    return token;
  }
}
