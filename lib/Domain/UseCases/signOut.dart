import 'package:Cars/Domain/Repositories/firebaseRepo.dart';

class SignOut {
  final FirebaseRepository firebaseRepository;

  SignOut(this.firebaseRepository);

  Future <void> call() async{
    return await firebaseRepository.signOut();
  }

}
