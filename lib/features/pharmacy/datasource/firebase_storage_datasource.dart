import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageDatasource {
  Future<void> deleteImages(List<String> imagesUrl) async {
    for (var imageUrl in imagesUrl) {
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
    }
  }
}
