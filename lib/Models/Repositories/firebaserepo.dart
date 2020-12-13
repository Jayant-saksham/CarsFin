import 'package:Cars/Domain/Entities/User_entity.dart';
import 'package:Cars/Domain/Repositories/firebaseRepo.dart';

class FirebaseRepositoryImp implements FirebaseRepository {
  @override
  Future<void> getCreateCurrentUser(UserEntity user) {
      // TODO: implement getCreateCurrentUser
      throw UnimplementedError();
    }
  
    @override
    Future<String> getCurrentUID() {
      // TODO: implement getCurrentUID
      throw UnimplementedError();
    }
  
    @override
    Future<bool> isSignIn() {
      // TODO: implement isSignIn
      throw UnimplementedError();
    }
  
    @override
    Future<void> signInWithPhoneNumber(String smsPinCode) {
      // TODO: implement signInWithPhoneNumber
      throw UnimplementedError();
    }
  
    @override
    Future<void> signOut() {
      // TODO: implement signOut
      throw UnimplementedError();
    }
  
    @override
    Future<void> verifyPhoneNumber(String phoneNumber) {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }

}