import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_id/dart_id.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/features/pharmacy/models/pharmacy_model.dart';

class PharmacyDatasource {
  Future<List<PharmacyModel>> getUserPharmacies(String userId) async {
    var docs = (await FirebaseFirestore.instance
            .collection(Collections.pharmacies)
            .where(
              'personnel.userId',
              isEqualTo: userId,
            )
            .get())
        .docs;
    var pharmacies = docs.map((e) => PharmacyModel.fromJson(e.data())).toList();
    return pharmacies;
  }

  Future<PharmacyModel> createPharmacy({
    required String name,
    required String address,
    required String ownerId,
  }) async {
    final now = DateTime.now();
    String id = DartID().generate();
    PharmacyPerson ownerModel = PharmacyPerson(
      userId: ownerId,
      addedAt: now,
      endAt: null,
      role: PharmacyRole.owner,
    );
    PharmacyModel pharmacyModel = PharmacyModel(
      id: id,
      name: name,
      address: address,
      createdAt: DateTime.now(),
      personnel: [ownerModel],
    );
    await FirebaseFirestore.instance
        .collection(Collections.pharmacies)
        .doc(id)
        .set(pharmacyModel.toJson());

    return pharmacyModel;
  }
}
