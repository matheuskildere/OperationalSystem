import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinepoints;
  final String? distance;
  final String? duration;

  DirectionsModel(
      {required this.bounds,
      required this.polylinepoints,
      required this.distance,
      required this.duration});

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    final data = Map<String, dynamic>.from(map['routes'][0] as Map);

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'] as double, northeast['lng'] as double),
      southwest: LatLng(southwest['lat'] as double, southwest['lng'] as double),
    );
    return DirectionsModel(
      bounds: bounds,
      polylinepoints: PolylinePoints()
          .decodePolyline(data['overview_polyline']['points'].toString()),
      distance: 'aaaaa',
      duration: 'ddfddg',
    );
  }
}
