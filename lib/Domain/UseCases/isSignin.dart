import 'package:Cars/Domain/Repositories/firebaseRepo.dart';
import 'package:firebase_core/firebase_core.dart';

class IsSignIn {
  final FirebaseRepository firebaseRepository;

  IsSignIn(this.firebaseRepository);
  Future<bool> isSignIn() async {
    return await firebaseRepository.isSignIn();
  }
}
