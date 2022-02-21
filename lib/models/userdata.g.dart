// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userdata _$UserdataFromJson(Map<String, dynamic> json) => Userdata()
  ..id = json['id'] as String
  ..name = json['name'] as String?
  ..age = json['age'] as String?
  ..rentgiven = json['rentgiven'] as String?
  ..monthlyrent = json['monthlyrent'] as String?
  ..contactnumber = json['contactnumber'] as String?;

Map<String, dynamic> _$UserdataToJson(Userdata instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'rentgiven': instance.rentgiven,
      'monthlyrent': instance.monthlyrent,
      'contactnumber': instance.contactnumber,
    };
