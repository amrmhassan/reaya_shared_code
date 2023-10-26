import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/features/pharmacy/models/pharmacy_model.dart';

class PharmacyDatasource {
  Future<List<String>?> getPharmacyStuff(String pharmacyId) async {
    var model = await getPharmacyById(pharmacyId);
    if (model == null) return null;
    return model.usersIds;
  }

  Future<PharmacyModel?> getPharmacyById(String id) async {
    var doc = (await FirebaseFirestore.instance
            .collection(Collections.pharmacies)
            .doc(id)
            .get())
        .data();
    if (doc == null) return null;
    var model = PharmacyModel.fromJson(doc);
    return model;
  }

  Future<List<PharmacyModel>> getAllPharmacies() async {
    var docs = (await FirebaseFirestore.instance
            .collection(Collections.pharmacies)
            .get())
        .docs;
    var data = docs.map((e) => PharmacyModel.fromJson(e.data())).toList();
    return data;
  }

  Future<List<PharmacyModel>> getActivePharmacies() async {
    var p = await getAllPharmacies();
    var accepted = p.where((e) => e.status == PharmacyStatus.accepted).toList();
    return accepted;
  }
}
