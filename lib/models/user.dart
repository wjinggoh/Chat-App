import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String userEmail;
  final String? profilePictureUrl; // Optional for users without a profile picture

  UserModel({
    required this.username,
    required this.userEmail,
    this.profilePictureUrl, // This field is optional
  });

  // Convert UserModel object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': userEmail,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Create UserModel object from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      userEmail: map['email'] ?? '',
      profilePictureUrl: map['profilePictureUrl'], // Can be null
    );
  }

  // Create UserModel object from Firestore DocumentSnapshot
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      username: data['username'] ?? '',
      userEmail: data['email'] ?? '',
      profilePictureUrl: data['profilePictureUrl'],
    );
  }
}
