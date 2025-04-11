// test/mocks/mocks.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  FirebaseAuth,
  UserCredential,
  User,
  FirebaseFirestore,
  CollectionReference<Map<String, dynamic>>, // ✅ Fix here
  DocumentReference<Map<String, dynamic>>,   // ✅ If you use it
])
void main() {}
