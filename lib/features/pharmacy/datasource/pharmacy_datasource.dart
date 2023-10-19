// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:reaya_shared_code/constants/collections.dart';
// import 'package:reaya_shared_code/features/pharmacy/models/pharmacy_model.dart';

// class PharmacyDatasource {
//   Future<List<PharmacyModel>> getUserPharmacies(String userId) async {
//     var docs = (await FirebaseFirestore.instance
//             .collection(Collections.pharmacies)
//             .where(
//               'personnel.userId',
//               isEqualTo: userId,
//             )
//             .get())
//         .docs;
//     var pharmacies = docs.map((e) => PharmacyModel.fromJson(e.data())).toList();
//     return pharmacies;
//   }
// }
