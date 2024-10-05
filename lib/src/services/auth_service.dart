import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoquest/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerUser(String email, String password, String username,
      String phoneNumber) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        UserModel localUser = UserModel(
          uid: user.uid,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          gamePoints: 0,
          gameRank: 0,
          createdAt: Timestamp.now(),
        );
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(localUser.toFirestore());
        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception("Failed to register: ${e.message}");
    }
    return null;
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception("Failed to login: ${e.message}");
    }
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Failed to logout: ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return doc.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      throw Exception("Failed to load user data: $e");
    }
    return null;
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> saveUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
  }

  Future<String?> getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}
