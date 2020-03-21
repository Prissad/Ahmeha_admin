import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LookupCoordinate extends StatefulWidget {
  double longitude;
  double latitude;
  LookupCoordinate(this.latitude, this.longitude);
  @override
  State<StatefulWidget> createState() =>
      _LookupCoordinateState(this.latitude, this.longitude);
}

class _LookupCoordinateState extends State<LookupCoordinate> {
  double longitude;
  double latitude;
  _LookupCoordinateState(this.latitude, this.longitude);
  final Geolocator _geolocator = Geolocator();
  /*final TextEditingController _coordinatesTextController =
      TextEditingController();*/

  String _placemark = '';

  Future<void> _onLookupAddressPressed(
      double latitude, double longitude) async {
    /*final List<String> coords = _coordinatesTextController.text.split(',');
    final double latitude = double.parse(coords[0]);
    final double longitude = double.parse(coords[1]);*/
    final List<Placemark> placemarks =
        await _geolocator.placemarkFromCoordinates(latitude, longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      setState(() {
        _placemark = pos.administrativeArea +
            ', ' +
            pos.thoroughfare +
            ', ' +
            pos.locality +
            ', ' +
            pos.position.toString();
        /*_placemark = pos.name +
            ',' +
            pos.isoCountryCode +
            ',' +
            pos.country +
            ',' +
            pos.postalCode +
            ',' +
            pos.administrativeArea +
            ',' +
            pos.subAdministrativeArea +
            ',' +
            pos.locality +
            ',' +
            pos.subLocality +
            ',' +
            pos.thoroughfare +
            ',' +
            pos.subThoroughfare +
            ',' +
            pos.position.toString();*/
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return Column(
      children: <Widget>[
        TextField(
          decoration: const InputDecoration(hintText: 'latitude,longitude'),
          controller: _coordinatesTextController,
        ),
        RaisedButton(
          child: const Text('Look up...'),
          onPressed: () {
            _onLookupAddressPressed();
          },
        ),
        Text(_placemark),
      ],
    );*/
    _onLookupAddressPressed(this.latitude, this.longitude);
    return new Text(
      _placemark,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
      ),
    );
  }
}
