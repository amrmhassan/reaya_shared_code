// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_id/dart_id.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/constants/remote_storage.dart';
import 'package:reaya_shared_code/features/ads/data/models/ad_model.dart';

List<AdModel> _ads = [];

class ADsDatasource {
  Future<List<AdModel>> getAllAds({
    bool forceRemoteLoad = false,
  }) async {
    if (_ads.isNotEmpty && !forceRemoteLoad) return _ads;
    var docs =
        (await FirebaseFirestore.instance.collection(Collections.ads).get())
            .docs;
    var models = docs.map((e) => AdModel.fromJson(e.data())).toList();
    _ads = models;
    return models;
  }

  Future<List<AdModel>> getActiveAds() async {
    var allAds = await getAllAds();
    var models = allAds.where((element) => element.active).toList();
    return models;
  }

  Future<AdModel> createAd({
    required File image,
    required DateTime? endAt,
    required int activeSeconds,
    required bool active,
    required String? targetLink,
  }) async {
    String adId = DartID().generate();
    String imageUrl = await _uploadAdImage(image, adId);
    AdModel adModel = AdModel(
      id: adId,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      endAt: endAt,
      activeSeconds: activeSeconds,
      active: active,
      targetLink: targetLink,
    );
    await FirebaseFirestore.instance
        .collection(Collections.ads)
        .doc(adId)
        .set(adModel.toJson());
    _ads.add(adModel);
    return adModel;
  }

  Future<AdModel> updateAd({
    required AdModel oldModel,
    required File? image,
    required DateTime? endAt,
    required int activeSeconds,
    required bool active,
    required String? targetLink,
  }) async {
    String adId = oldModel.id;
    String imageUrl =
        image == null ? oldModel.imageUrl : (await _uploadAdImage(image, adId));

    AdModel adModel = AdModel(
      id: adId,
      imageUrl: imageUrl,
      createdAt: oldModel.createdAt,
      endAt: endAt ?? oldModel.endAt,
      activeSeconds: activeSeconds,
      active: active,
      targetLink: targetLink,
    );
    await FirebaseFirestore.instance
        .collection(Collections.ads)
        .doc(adId)
        .update(adModel.toJson());
    int index = _ads.indexWhere((element) => element.id == adId);
    _ads[index] = adModel;
    return adModel;
  }

  Future<String> _uploadAdImage(File file, String adId) async {
    var res = await FirebaseStorage.instance
        .ref(RemoteStorage.adsImages)
        .child(adId)
        .putFile(file);
    return res.ref.getDownloadURL();
  }

  Future<void> deleteAd(String adId) async {
    //! delete the ad image
    await FirebaseStorage.instance
        .ref(RemoteStorage.adsImages)
        .child(adId)
        .delete();

    await FirebaseFirestore.instance
        .collection(Collections.ads)
        .doc(adId)
        .delete();
  }
}
