import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final bool isOnline;
  final String uid;
  final String profileUrl;

  UserEntity(
      this.name,
      this.email,
      this.phoneNumber,
      this.isOnline,
      this.uid,
      this.profileUrl);

  @override
  // TODO: implement props
  List<Object> get props =>
      [name, email, phoneNumber, uid, isOnline, profileUrl];
}
