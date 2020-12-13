import 'package:Cars/Domain/Repositories/firebaseRepo.dart';

class GetCurrentUID {
  final FirebaseRepository firebaseRepository;

  GetCurrentUID(this.firebaseRepository);
  Future<String> call() async {
    return await firebaseRepository.getCurrentUID();
  }
}
