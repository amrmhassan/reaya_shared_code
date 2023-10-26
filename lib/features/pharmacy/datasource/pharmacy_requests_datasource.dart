import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_id/dart_id.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reaya_shared_code/features/notifications/send_notification_api.dart';
import 'package:reaya_shared_code/features/pharmacy/datasource/pharmacy_datasource.dart';
import 'package:reaya_shared_code/utils/errors/custom_exception.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';
import 'package:shared_code/shared_code.dart';
import 'package:reaya_shared_code/features/pharmacy/models/pharmacy_request_model.dart';
import 'package:reaya_shared_code/features/pharmacy/datasource/firebase_storage_datasource.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/constants/remote_storage.dart';

class PharmacyRequestsDatasource {
  final FirebaseStorageDatasource _firebaseStorageDatasource =
      FirebaseStorageDatasource();

  void _validate({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String notes,
    required List<File> files,
  }) {
    // name
    if (name.length < 3) {
      throw CustomException('لا يمكن أن يكون الاسم أقل من 3 أحرف');
    }

    // phone
    if (phone.length < 10) {
      throw CustomException("من فضلك أدخل رقم هاتف صحيح");
    }
    // address
    if (address.length < 15) {
      throw CustomException("من فضلك أدخل عنوان لا يقل عن 15 حرف");
    }
    // files
    // if (files.isEmpty) {
    //   throw CustomException("لابد من اختيار صورة روشتة واحدة علي الأقل");
    // }
    // email
    if (email.isNotEmpty) {
      String? emailError = UserInfoValidation().emailValidation(email);
      if (emailError != null) {
        throw CustomException(emailError);
      }
    }
  }

  Future<void> createPharmacyRequest({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String notes,
    required List<File> files,
    required String pharmacyId,
  }) async {
    _validate(
      name: name,
      phone: phone,
      address: address,
      email: email,
      notes: notes,
      files: files,
    );

    String? userId = firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw CustomException('User is not logged in');
    }
    final now = DateTime.now();
    final state = PharmacyRequestModelState(
      state: RequestModelState.pending,
      statedAt: now,
    );
    List<String> images = await _uploadImages(files);
    try {
      String id = DartID().generate();
      PharmacyRequestModel model = PharmacyRequestModel(
        id: id,
        name: name,
        phone: phone,
        address: address,
        email: email,
        notes: notes,
        images: images,
        userId: userId,
        pharmacyId: pharmacyId,
        createdAt: now,
        state: state,
      );
      await FirebaseFirestore.instance
          .collection(Collections.pharmacyRequests)
          .doc(id)
          .set(model.toJson());
      await _sendPharmacyNotification(pharmacyId);
    } catch (e) {
      await _firebaseStorageDatasource.deleteImages(images);
    }
  }

  Future<List<String>> _uploadImages(List<File> files) async {
    List<String> images = [];
    for (var file in files) {
      String imageId = DartID().generate();
      var res = await FirebaseStorage.instance
          .ref(RemoteStorage.imagePharmacyRequests)
          .child(imageId)
          .putFile(file);
      String url = await res.ref.getDownloadURL();
      images.add(url);
    }
    return images;
  }

  Future<void> _sendPharmacyNotification(String id) async {
    PharmacyDatasource datasource = PharmacyDatasource();
    var ids = await datasource.getPharmacyStuff(id);
    if (ids == null) return;
    for (var id in ids) {
      await SendNotificationApi.sendNotification(
        userId: id,
        title: 'طلبية جديدة',
        body: "برجاء مراجعة طلبياتك",
        payload: {},
      );
    }
  }

  Future<List<PharmacyRequestModel>> loadPharmacyRequests(String id) async {
    var docs = (await FirebaseFirestore.instance
            .collection(Collections.pharmacyRequests)
            .where('pharmacyId', isEqualTo: id)
            .get())
        .docs;
    var models =
        docs.map((e) => PharmacyRequestModel.fromJson(e.data())).toList();
    return models;
  }

  Future<PharmacyRequestModelState> updateRequestStatus({
    required String requestId,
    required RequestModelState state,
    required String notes,
  }) async {
    PharmacyRequestModelState modelState = PharmacyRequestModelState(
      state: state,
      statedAt: DateTime.now(),
      notes: notes,
    );
    await FirebaseFirestore.instance
        .collection(Collections.pharmacyRequests)
        .doc(requestId)
        .update({'state': modelState.toJson()});
    return modelState;
  }
}
