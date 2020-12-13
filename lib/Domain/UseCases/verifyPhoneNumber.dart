import 'package:Cars/Domain/Repositories/firebaseRepo.dart';

class VerifyPhoneNumber {
  final FirebaseRepository firebaseRepository;

  VerifyPhoneNumber({this.firebaseRepository});

  Future<void> call(String phoneNumber) async {
    return await firebaseRepository.verifyPhoneNumber(phoneNumber);
  }
}
