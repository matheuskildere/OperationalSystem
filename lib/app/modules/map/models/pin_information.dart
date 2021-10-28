import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {
  final String pinPath;
  final String avatarPath;
  final LatLng location;
  final String locationName;
  final Color labelColor;
  PinInformation({
    required this.pinPath,
    required this.avatarPath,
    required this.location,
    required this.locationName,
    required this.labelColor,
  });
}
