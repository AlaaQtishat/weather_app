import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) {
        List<String> nameParts = (firebaseUser.displayName ?? "User").split(
          " ",
        );
        String fName = nameParts.isNotEmpty ? nameParts[0] : "User";
        String lName = nameParts.length > 1
            ? nameParts.sublist(1).join(" ")
            : "";

        UserModel newUser = UserModel(
          fname: fName,
          lname: lName,
          email: firebaseUser.email ?? "",
          phoneNumber: "Not provided",
          birthdate: "Not provided",
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set(newUser.toJson());
      }
    }
  }
}
