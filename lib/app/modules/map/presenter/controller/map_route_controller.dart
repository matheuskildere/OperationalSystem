import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/modules/map/models/directions_model.dart';
import 'package:feelps/app/modules/map/presenter/repository/map_route_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'map_route_controller.g.dart';

class MapRouteController = _MapRouteController with _$MapRouteController;

abstract class _MapRouteController with Store {
  final IMapRouteRepository _repository;

  _MapRouteController(this._repository);

  @action
  Future<CameraPosition> initialLocation() async {
    final result = await Location().getLocation();
    if (result.latitude != null && result.longitude != null) {
      return CameraPosition(
          target: LatLng(result.latitude!, result.longitude!));
    } else {
      return CameraPosition(
          target: LatLng(-23.52301576940105, -46.53657805244674));
    }
  }

  @observable
  DirectionsModel? directions;

  @observable
  String? serviceId;

  @observable
  DialogDataEntity? dialogData;

  @action
  Future<DirectionsModel?> getDirections() async {
    final result = await _repository.getRoute(serviceId: serviceId!);

    return result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
      return null;
    }, (r) {
      directions = r;
      return directions!;
    });
  }

  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  Future<void> createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCEwNIYKlBVix67Im1MVTMWLGMg7vfK8d4', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
      avoidHighways: true,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    final PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }
}
