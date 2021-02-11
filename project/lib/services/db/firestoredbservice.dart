import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterhackathon_firecode/models/positionmodel.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/services/db/dbbase.dart';

class FireStoreDBService implements DBBase {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<UserModel> readUser(String userID) async {
    DocumentSnapshot _readedUser =
        await _fireStore.collection('users').doc(userID).get();
    Map<String, dynamic> _readedUserMap = _readedUser.data();

    UserModel _readedUserObject = UserModel.fromMap(_readedUserMap);
    print("Okunan User Nesnesi : " + _readedUserObject.toString());
    return _readedUserObject;
  }

  @override
  Future<bool> saveUser(UserModel user) async {
    DocumentSnapshot _readedUser =
        await _fireStore.doc('users/${user.userID}').get();
    Map _readedUserMap = _readedUser.data();

    if (_readedUserMap == null) {
      await _fireStore.collection("users").doc(user.userID).set(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<bool> savePosition(PositionModel positionModel) async{
    var _docID = _fireStore.collection("Positions").doc().id;
    await _fireStore
        .collection("Positions")
        .doc("Users").collection(positionModel.user.userID).doc(_docID)
        .set(positionModel.toMap());
    return true;
  }
}