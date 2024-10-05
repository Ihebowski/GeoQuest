import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoquest/src/models/user_model.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromFirestore(doc);
        }
      }
    } catch (e) {
      throw Exception("Failed to load user data: $e");
    }
    return null;
  }

  Future<void> saveUserData(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toFirestore());
    } catch (e) {
      throw Exception("Failed to save user data: $e");
    }
  }

  Future<void> updateUserGamePoints(String uid, int newGamePoints) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'gamePoints': newGamePoints,
      });
    } catch (e) {
      throw Exception("Failed to update game points: $e");
    }
  }

  Future<void> updateGameRanks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();

      List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc);
      }).toList();

      users.sort((a, b) {
        int aPoints = a.gamePoints;
        int bPoints = b.gamePoints;
        return bPoints.compareTo(aPoints);
      });

      for (int rank = 0; rank < users.length; rank++) {
        String userId = users[rank].uid;
        await _firestore.collection('users').doc(userId).update({
          'gameRank': rank + 1,
        });
      }
    } catch (e) {
      throw Exception("Failed to update game ranks: $e");
    }
  }
}
