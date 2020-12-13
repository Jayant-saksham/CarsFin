import 'package:Cars/Domain/Entities/User_entity.dart';
import 'package:flutter/material.dart';

abstract class FirebaseRepository {
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUID();
  Future<void> getCreateCurrentUser(UserEntity user);
  
}
