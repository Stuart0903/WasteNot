//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
//
// class UserModel{
//   //Keep those values final which you do not want to update
//   final String id;
//   String firstName;
//   String lastName;
//   final String userName;
//   final String email;
//   String phoneNumber;
//   String profilePicture;
//
//   ///Constructor for user Model
//   UserModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.userName,
//     required this.email,
//     required this.phoneNumber,
//     required this.profilePicture
// });
//   ///Helper function to get the full name
//   String get fullName => '$firstName $lastName';
//
//   // ///Helper function to format phone number
//   // String get formattedPhoneNo = WNFormatter.format
//   ///Static function to split full name into first and last name
//   static List<String> nameParts(fullName) => fullName.split("");
//
//   // /// Static function to generate a username from the full name.
//   // static String generateUsername(fullName) {
//   //   List<String> nameParts = fullName.split(" ");
//   //   String firstName = nameParts[0].toLowerCase();
//   //   String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
//   //
//   //   String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
//   //   String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
//   //
//   //   return usernameWithPrefix;
//   // }
//
//   ///Static function to create an empty user model
//   static UserModel empty() => UserModel(
//       id: '',
//       firstName: '',
//     lastName: '',
//     userName: '',
//     email: '',
//     phoneNumber: '',
//     profilePicture: '',
//   );
//
//   ///Convert model to JSON structure for storing data in Firebase
//   Map<String, dynamic> toJson(){
//     return{
//       'FirstName': firstName,
//       'LastName': lastName,
//       'UserName': userName,
//       'Email': email,
//       'PhoneNumber': phoneNumber,
//       'ProfilePicture': profilePicture,
//     };
//   }
//   ///Factory method to create a UserModel from a Firebase document snapshot
//   // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>document){
//   //   if (document.data()! = null){
//   //     final data = document.data()!;
//   //     return UserModel(
//   //         id: document.id,
//   //         firstName: data['FirstName'] ?? '',
//   //         lastName: data['LastName'] ?? '',
//   //         userName: data['UserName'] ?? '',
//   //         email: data['Email'] ?? '',
//   //         phoneNumber: data['PhoneNumber'] ?? '',
//   //         profilePicture: data['ProfilePicture'] ?? ''
//   //     );
//   //   }
//   // }
//
//
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  String get fullName => '$firstName $lastName';

  static List<String> nameParts(String fullName) => fullName.split(" ");

    /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix

    return usernameWithPrefix;
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        userName: data['userName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  static UserModel empty() {
    return UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
    );
  }
}
