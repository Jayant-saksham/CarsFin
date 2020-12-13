import 'package:Cars/Domain/Entities/User_entity.dart';
import 'package:Cars/Domain/Repositories/firebaseRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetCurrentUser {
  final FirebaseRepository firebaseRepository;

  GetCurrentUser(this.firebaseRepository);

  Future<void> call(UserEntity user) async {
    return await firebaseRepository.getCreateCurrentUser(user);
  }
}
