import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterhackathon_firecode/services/storage/storagebase.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _storageReference;
  var uuid = Uuid();
  @override
  Future<String> uploadFile(
      String userID, String fileType, File document) async {
    var docID = uuid.v1();
    _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(docID)
        .child(fileType)
        .child("nature_photo");
    UploadTask uploadTask = _storageReference.putFile(document);
    var url = await uploadTask.then((a) => a.ref.getDownloadURL());
    return url;
  }
}
