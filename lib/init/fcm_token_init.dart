import 'package:reaya_shared_code/features/notifications/fcm_tokens_source.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';

class FCMTokenInit {
  static void saveToken() async {
    try {
      // bool saved = await _tokenSaved();
      // if (saved) return;
      String token = await firebaseNotifications.getFCMToken();
      if (token.isEmpty) return;
      FCMTokensSource source = FCMTokensSource();
      bool done = await source.saveMyToken(token);
      if (!done) return;
      // await _setSaved();
    } catch (e) {
      logger.e(e);
    }
  }
}
