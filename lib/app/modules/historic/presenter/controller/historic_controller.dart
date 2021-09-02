import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/modules/historic/repositories/historic_repository.dart';
import 'package:feelps/app/modules/map/models/directions_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'historic_controller.g.dart';

class HistoricController = _HistoricController with _$HistoricController;

abstract class _HistoricController with Store {
  final IHistoricRepository _repository;

  _HistoricController(this._repository);

  @observable
  DialogDataEntity? dialogData;

  @observable
  List<ServiceEntity>? services;

  @observable
  String? errorMessage;

  @observable
  String? serviceId;

  @observable
  DirectionsModel? directions;

  @action
  Future<void> getServices() async {
    final authStore = Modular.get<AuthStore>();

    final result = await _repository.getHistoric(authStore.deliveryman!.id!);

    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
      errorMessage = 'Não foi possível buscar seus serviços';
    }, (r) {
      services = r;
    });
  }

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
    final PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCEwNIYKlBVix67Im1MVTMWLGMg7vfK8d4', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      avoidHighways: true,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
  }
}
