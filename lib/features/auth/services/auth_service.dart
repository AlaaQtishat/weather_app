import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/features/user/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> createAccount({
    required UserModel user,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );

    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;
      await userCredential.user!.updateDisplayName(
        "${user.fname} ${user.lname}",
      );

      Map<String, dynamic> userData = user.toJson();
      userData['uid'] = uid;
      userData['created_at'] = FieldValue.serverTimestamp();

      await _firestore.collection('users').doc(uid).set(userData);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
