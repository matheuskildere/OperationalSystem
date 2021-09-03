import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceCalculator {
  static double distanceCalculatorBetweenTwo({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    final p = 0.017453292519943295;
    final c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static double distanceCalculatorByList(List<LatLng> list) {
    double totalDistance = 0.0;
    for (int i = 0; i < list.length - 1; i++) {
      totalDistance += distanceCalculatorBetweenTwo(
        lat1: list[i].latitude,
        lon1: list[i].longitude,
        lat2: list[i + 1].latitude,
        lon2: list[i + 1].longitude,
      );
    }
    return totalDistance;
  }
}
