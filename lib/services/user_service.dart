import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scam_stories_app/services/api_status.dart';

CollectionReference _users = FirebaseFirestore.instance.collection('users');

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> login(String email, String pwd) async {
    UserCredential register;
    try {
      register = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
    } catch (e) {
      FirebaseAuthException? error;
      error = e as FirebaseAuthException?;
      return Failure(msg: error!.message!);
    }
    print(register.user);
    return Success(msg: 'Welcome Back', response: register.user);
  }

  Future<dynamic> signUp(
    String fullname,
    String email,
    String pwd,
  ) async {
    UserCredential register;
    try {
      register = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
    } catch (e) {
      FirebaseAuthException? error;
      error = e as FirebaseAuthException?;
      return Failure(msg: error!.message!);
    }

    return Success(msg: 'Welcome $fullname', response: register.user);
  }

  logout() {
    _auth.signOut();
  }

  Future<void> updateUserImg(String imgUrl, String userId) async {
    await _users.doc(userId).update({
      'img': imgUrl,
    });
  }
}
