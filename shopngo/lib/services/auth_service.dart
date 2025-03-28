// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopngo/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password, UserRole role) async {
    try {
      // Create user with email and password
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'role': role.name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      throw e; // Rethrow the exception
    } catch (e) {
      print("Error during sign up: $e");
      throw e; // Rethrow the exception
    }
  
  }

  Future<UserModel?> getUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return UserModel.fromJson(userDoc.data()!);
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
    return null;
  }

   // Sign In with Email and Password
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Sign In Error: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected Error: $e');
      return null;
    }
  }
}
