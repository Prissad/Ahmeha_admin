// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
      json['longitude'] as double,
      json['latitude'] as double,
      json['location'] as String,
      json['type'] as String,
      json['urlToImage'] as String,
      json['time'] as String,
      json['affichage'] as bool);
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'type': instance.type,
      'urlToImage': instance.urlToImage,
      'time': instance.time,
    };
