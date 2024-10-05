import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String username;
  String email;
  String phoneNumber;
  int gamePoints;
  int gameRank;
  Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.gamePoints,
    required this.gameRank,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      uid: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      gamePoints: data['gamePoints'] ?? '0',
      gameRank: data['gameRank'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'gamePoints': gamePoints,
      'gameRank': gameRank,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({int? gamePoints, int? gameRank}) {
    return UserModel(
      uid: uid,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      createdAt: createdAt,
      gamePoints: gamePoints ?? this.gamePoints,
      gameRank: gameRank ?? this.gameRank,
    );
  }
}
