import 'package:json_annotation/json_annotation.dart';
import 'Report.dart';

part 'ReportResponse.g.dart';

@JsonSerializable()
class ReportResponse {
  String status;
  var totalResults;
  List<Report> articles;

  ReportResponse(this.status, this.totalResults, this.articles);

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}
