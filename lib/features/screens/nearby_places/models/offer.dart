
import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offer.g.dart';
@JsonSerializable()
class Offer{
  String? uid;
  String? title;
  String? off;
  String? imgUrl;
  String? place;

  Offer({
    this.uid,
    this.title,
    this.off,
    this.imgUrl,
    this.place,
  });
  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);


}