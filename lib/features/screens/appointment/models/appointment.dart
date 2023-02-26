import 'package:json_annotation/json_annotation.dart';
part 'appointment.g.dart';
@JsonSerializable()
class Appointment{
  String? appointmentId;
  String? userId;
  String? placeId;
  String? userName;
  String? placeName;
  String? status;
  String? userPhone;
  String? cartype;
  String? kind;
  String? date;
  String? time;
  bool? paid;
  String? amount;

  Appointment({this.userId, this.placeId, this.userName, this.placeName, this.status,
    this.userPhone, this.cartype,this.kind, this.date, this.time,this.paid = false,this.amount= '10000'});
  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);


}