import 'package:json_annotation/json_annotation.dart';
part 'notifications.g.dart';
@JsonSerializable()
class Notifications{
  String? userId;  
  String? time;
  String? title;
  String? from;

  Notifications({this.userId, this.time, this.title, this.from});

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

}