import 'package:Cars/Domain/Repositories/firebaseRepo.dart';
import 'package:firebase_core/firebase_core.dart';

class SignInPhone {
  final FirebaseRepository firebaseRepository;

  SignInPhone(this.firebaseRepository);
  Future<void> call(String smsPinCode) async{
    return await firebaseRepository.signInWithPhoneNumber(smsPinCode);
  }
}
