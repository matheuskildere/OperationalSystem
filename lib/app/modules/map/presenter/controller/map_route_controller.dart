import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/modules/map/models/directions_model.dart';
import 'package:feelps/app/modules/map/presenter/repository/map_route_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'map_route_controller.g.dart';

class MapRouteController = _MapRouteController with _$MapRouteController;

abstract class _MapRouteController with Store {
  final IMapRouteRepository _repository;

  _MapRouteController(this._repository);

  @observable
  DirectionsModel? directions;

  @observable
  String? serviceId;

  @observable
  DialogDataEntity? dialogData;

  @observable
  LocationData? locationData;

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

  // @action
  // Future<LatLng?> getLocation() async {
  //   final result = await Location().getLocation();
  //   if (result.latitude != null && result.longitude != null) {
  //     return LatLng(result.latitude!, result.longitude!);
  //   }
  // }

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
}
