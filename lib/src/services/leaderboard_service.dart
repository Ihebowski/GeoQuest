import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoquest/src/models/user_model.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchLeaderboard() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .orderBy('gamePoints', descending: true)
          .get();

      List<UserModel> leaderboard = snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc);
      }).toList();

      return leaderboard;
    } catch (e) {
      throw Exception('Error fetching leaderboard: $e');
    }
  }
}
