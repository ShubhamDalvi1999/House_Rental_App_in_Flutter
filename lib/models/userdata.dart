import 'package:json_annotation/json_annotation.dart';

part 'userdata.g.dart';

@JsonSerializable()
class Userdata {
  Userdata();

  late String id;
  String? name;
  String? age;
  String? rentgiven;
  String? monthlyrent;
  String? contactnumber;
  
  factory Userdata.fromJson(Map<String,dynamic> json) => _$UserdataFromJson(json);
  Map<String, dynamic> toJson() => _$UserdataToJson(this);
}
