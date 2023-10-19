import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageDatasource {
  Future<void> deleteImages(List<String?> imagesUrl) async {
    for (var imageUrl in imagesUrl) {
      if (imageUrl == null) continue;
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
    }
  }
}
