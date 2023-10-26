import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reaya_shared_code/constants/collections.dart';
import 'package:reaya_shared_code/features/auth/datasource/user_datasource.dart';
import 'package:reaya_shared_code/features/notifications/send_notification_api.dart';
import 'package:reaya_shared_code/features/pharmacy/models/pharmacy_model.dart';
import 'package:reaya_shared_code/features/pharmacy_review/data/models/review_pharmacy_model.dart';

class ReviewPharmacyDatasource {
  Future<void> sendPharmacyReview(
    String pharmacyId,
    Future<PharmacyModel?> Function(
      String pharmacyId,
      PharmacyStatus status,
    ) updatePharmacyStatus,
  ) async {
    ReviewPharmacyModel model = ReviewPharmacyModel(
      pharmacyId: pharmacyId,
      sentAt: DateTime.now(),
    );
    await FirebaseFirestore.instance
        .collection(Collections.pharmacyReviews)
        .doc(pharmacyId)
        .set(model.toJson());
    // sending notifications
    await _sendAdminNotifications();
    // updating the pharmacy status
    await updatePharmacyStatus(pharmacyId, PharmacyStatus.reviewPending);
  }

  Future<List<ReviewPharmacyModel>> loadPharmacyRequests() async {
    var docs = (await FirebaseFirestore.instance
            .collection(Collections.pharmacyReviews)
            .get())
        .docs;
    var models =
        docs.map((e) => ReviewPharmacyModel.fromJson(e.data())).toList();
    return models;
  }

  Future<void> _sendAdminNotifications() async {
    UserDatasource userDatasource = UserDatasource();
    var admins = await userDatasource.getAdmins();
    for (var admin in admins) {
      SendNotificationApi.sendNotification(
        userId: admin.id,
        title: 'مراجعة صيدلية',
        body: "طلب مراجعة صيدلية جديد",
        payload: {},
      );
    }
  }
}
