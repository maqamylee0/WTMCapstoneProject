
import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'place.g.dart';
@JsonSerializable()
class Place{
  String? uid;
  String? name;
  String? latitude;
  String? longitude;
  String? address;
  String? rating;
  String? imgUrl;

  Place({this.uid,this.name,this.latitude,this.longitude,this.address,this.rating});
  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}