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
}
