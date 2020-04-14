import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Report {
  int id;
  double longitude;
  double latitude;
  double distance;
  String type;
  String urlToImage;
  String time;
  String description;
  bool affichage;

  Report(this.id, this.longitude, this.latitude, this.type, this.urlToImage,
      this.time, this.description, this.affichage);

  setDistance(longitude, latitude) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double distance = await Geolocator().distanceBetween(
        longitude, latitude, position.longitude, position.latitude);
    this.distance = distance;
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    int val = json['affichage'] as int;
    bool affichage = true;
    if (val == 0) affichage = false;
    return Report(
        json['id'] as int,
        json['longitude'] as double,
        json['latitude'] as double,
        json['type'] as String,
        ('http://51.178.54.128:2020/' + (json['urlToImage'] as String)),
        json['time'] as String,
        json['description'] as String,
        affichage);
  }
}
