import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable()
class Users {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? photoUrl;


  Users({this.uid, this.email, this.name, this.phone,this.photoUrl});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

}