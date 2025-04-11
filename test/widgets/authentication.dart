import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastenot/features/authentication/models/user_model.dart';
import 'package:wastenot/utils/exceptions/format_exceptions.dart';

// Import the generated mocks
import '../mocks/mocks.mocks.dart';
import '../services/registration_services.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late UserRepository userRepository; // Replace with your actual class name

  setUp(() {
    // Initialize mocks
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();

    // Setup mock user
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('test-user-id');

    // Setup Firestore mock collection/document references
    when(mockFirebaseFirestore.collection('Users'))
        .thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any))
        .thenReturn(mockDocumentReference);
    when(mockDocumentReference.set(any))
        .thenAnswer((_) => Future.value());

    // Initialize repository with mocks
    userRepository = UserRepository(
      auth: mockFirebaseAuth,
      db: mockFirebaseFirestore,
    );
  });

  group('Account Creation Tests', () {
    test('Register with valid email and password', () async {
      // Arrange - setup Firebase Auth to return success
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123',
      )).thenAnswer((_) => Future.value(mockUserCredential));

      // Act - call the method being tested
      final result = await userRepository.registerWithEmailandPassword(
        'test@example.com',
        'Password123',
      );

      // Assert - verify the result and that Firebase was called correctly
      expect(result, equals(mockUserCredential));
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123',
      )).called(1);

      // Log detailed information for debug purposes
      print('Register with valid email and password - Result: $result');
      print('Expected Email: test@example.com');
      print('Expected Password: Password123');
    });

    test('Save user record to Firestore', () async {
      // Arrange - create test user model
      final testUser = UserModel(
        id: 'test-user-id',
        firstName: 'John',
        lastName: 'Doe',
        userName: 'cwt_johndoe',
        email: 'test@example.com',
        phoneNumber: '+1234567890',
      );

      // Act - call the method being tested
      await userRepository.saveUserRecord(testUser);

      // Assert - verify Firestore was called with correct data
      verify(mockFirebaseFirestore.collection('Users')).called(1);
      verify(mockCollectionReference.doc('test-user-id')).called(1);
      verify(mockDocumentReference.set(testUser.toJson())).called(1);

      // Log the data that was saved
      print('Saving User: ${testUser.toJson()}');
      print('Expected Data: {FirstName: John, LastName: Doe, UserName: cwt_johndoe, Email: test@example.com, PhoneNumber: +1234567890}');
    });

    test('Complete account creation flow', () async {
      // Arrange - setup Firebase Auth to return success
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123',
      )).thenAnswer((_) => Future.value(mockUserCredential));

      // Act - simulate the complete registration flow
      final credentials = await userRepository.registerWithEmailandPassword(
        'test@example.com',
        'Password123',
      );

      final user = UserModel(
        id: mockUser.uid,
        firstName: 'John',
        lastName: 'Doe',
        userName: 'cwt_johndoe',
        email: 'test@example.com',
        phoneNumber: '+1234567890',
      );

      await userRepository.saveUserRecord(user);

      // Assert - verify both functions were called correctly
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123',
      )).called(1);

      verify(mockFirebaseFirestore.collection('Users')).called(1);
      verify(mockCollectionReference.doc('test-user-id')).called(1);
      verify(mockDocumentReference.set(user.toJson())).called(1);

      // Log the final complete flow details
      print('Complete account creation flow');
      print('User Created: ${user.toJson()}');
      print('Firestore Document Set: ${user.toJson()}');
    });

    test('Register with invalid email format throws FormatException', () async {
      expect(
            () => userRepository.registerWithEmailandPassword(
          'invalid-email',
          'Password123',
        ),
        throwsA(isA<WNFormatException>()), // Changed here
      );

      verifyNever(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));

      print('Correctly rejected invalid email format');
    });

    test('Login with valid email and password', () async {
      // Arrange - setup Firebase Auth to return success
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'valid@example.com',
        password: 'CorrectPassword123',
      )).thenAnswer((_) => Future.value(mockUserCredential));

      // Act
      final result = await userRepository.loginWithEmailAndPassword(
        'valid@example.com',
        'CorrectPassword123',
      );

      // Assert
      expect(result, equals(mockUserCredential));
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'valid@example.com',
        password: 'CorrectPassword123',
      )).called(1);

      print('Successfully logged in with valid credentials');
    });

    test('Login with invalid email format throws WNFormatException', () async {
      // Act & Assert
      expect(
            () => userRepository.loginWithEmailAndPassword('invalid-email', 'anypassword'),
        throwsA(isA<WNFormatException>()),
      );

      verifyNever(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));

      print('Correctly rejected login with invalid email format');
    });

  });
}
