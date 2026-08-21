import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/features/user/models/user_model.dart';

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserModel?> getUserData(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
