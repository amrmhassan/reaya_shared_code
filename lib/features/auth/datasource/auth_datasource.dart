import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';
import 'package:reaya_shared_code/utils/errors/custom_exception.dart';
import 'package:shared_code/shared_code/validation/user_info_validation.dart';

class AuthDatasource {
  final String _countryCode = '+2';

  Future<void> verifyPhone(
    String phoneNumber, {
    required void Function(String, int?) codeSent,
  }) async {
    if (phoneNumber.length != 11) {
      throw CustomException('رقم الهاتف لابد أن يكون 11 رقما فقط');
    }
    Completer<void> completer = Completer();
    String? error = UserInfoValidation().phoneValidation(phoneNumber);
    if (error != null) {
      throw CustomException(error);
    }
    phoneNumber = '$_countryCode$phoneNumber';
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        var sms = credential.smsCode;

        logger.i('sms: $sms');
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.completeError(
            e.message ?? 'Unknown Error occurred with code : ${e.code}');
      },
      codeSent: (verificationId, forceResendingToken) {
        completer.complete();
        codeSent(verificationId, forceResendingToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        logger.i('verificationId: $verificationId');
      },
    );
    return completer.future;
  }

  Future<void> verifyCode(String smsCode, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final authResult = await firebaseAuth.signInWithCredential(credential);
      var user = authResult.user;
      if (user == null) {
        throw Exception('User not signed');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? e.code);
    }
  }
}
