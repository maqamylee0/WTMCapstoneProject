import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable()
class Users {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? photoUrl;
  List? fav_placesId;


  Users({this.uid, this.email, this.name, this.phone,this.photoUrl,this.fav_placesId});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

}