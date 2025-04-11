import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  String gender;
  String dateOfBirth;
  String address;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    this.profilePicture = '',
    this.gender = '',
    this.dateOfBirth = '',
    this.address = '',
  });

  /// Helper function to get the full name
  String get fullName => '$firstName $lastName';

  /// Static function to split full name into first and last name
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix

    return usernameWithPrefix;
  }

  ///Static function to create an empty user model
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    userName: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
    gender: '',
    dateOfBirth: '',
    address: '',
  );

  /// Convert model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'Gender': gender,
      'DateOfBirth': dateOfBirth,
      'Address': address,
    };
  }

  /// Factory method to create a UserModel from a Firestore document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        gender: data['Gender'] ?? '',
        dateOfBirth: data['DateOfBirth'] ?? '',
        address: data['Address'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}