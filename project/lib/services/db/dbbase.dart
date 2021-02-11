import 'package:flutterhackathon_firecode/models/positionmodel.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';

abstract class DBBase{
  Future<bool> saveUser(UserModel user);
  Future<UserModel> readUser(String userID);
  Future<bool> savePosition(PositionModel positionModel);
}