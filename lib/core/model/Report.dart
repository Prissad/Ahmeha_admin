import 'package:json_annotation/json_annotation.dart';

part 'Report.g.dart';

@JsonSerializable()
class Report {
  double longitude;
  double latitude;
  String description;
  String type;
  String urlToImage;
  String time;
  bool affichage;

  Report(this.longitude, this.latitude, this.type, this.urlToImage, this.time,
      this.affichage);

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
