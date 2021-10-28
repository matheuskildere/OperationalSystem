import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/stores/auth_store.dart';
import 'package:feelps/app/modules/map/models/last_location_request.dart';
import 'package:feelps/app/modules/map/models/status_update_model.dart';
import 'package:feelps/app/modules/map/repositories/map_route_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';

part 'map_route_controller.g.dart';

class MapRouteController = _MapRouteController with _$MapRouteController;

abstract class _MapRouteController with Store {
  final IMapRouteRepository _repository;

  _MapRouteController(this._repository);

  @observable
  String? serviceId;

  @observable
  ServiceEntity? serviceEntity;

  @observable
  DialogDataEntity? dialogData;

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

  @action
  Future<void> getService() async {
    dialogData = null;
    final idDeliveryMan = Modular.get<AuthStore>().deliveryman!.id!;
    final result = await _repository.getService(
        serviceId: serviceId!, deliveryManId: idDeliveryMan);

    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
      return null;
    }, (r) {
      serviceEntity = r;
    });
  }

  @action
  Future<void> updateStatus(String? observation) async {
    dialogData = null;
    final result = await _repository.updateStatus(
        request: StatusUpdateModel(
            status: serviceEntity!.status.getNext().getDescription(),
            observation: observation,
            serviceId: serviceId!));

    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
      return null;
    }, (r) {
      serviceEntity = r;
    });
  }

  @action
  Future<void> updateLastLocation(
      {required double latitude, required double longitude}) async {
    dialogData = null;
    final idDeliveryMan = Modular.get<AuthStore>().deliveryman!.id!;
    final result = await _repository.updateLastLocation(
        request: LastLocationRequest(
            latitude: latitude,
            longitude: longitude,
            deliveryManId: idDeliveryMan));

    result.fold((l) {
      dialogData = DialogDataEntity(title: l.title, description: l.message);
    }, (r) {});
  }

  @action
  Future<void> verifyServiceStatus() async {
    if (serviceEntity!.status == DeliveryStatusEnum.wayToPickup) {
      dialogData = null;
      final result =
          await _repository.verifyServiceStatus(serviceId: serviceEntity!.id);

      result.fold((l) {
        dialogData = DialogDataEntity(title: l.title, description: l.message);
        serviceEntity =
            serviceEntity!.copyWith(status: DeliveryStatusEnum.canceled);
      }, (r) {});
    }
  }
}
