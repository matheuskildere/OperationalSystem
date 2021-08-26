import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:feelps/app/core/errors/failure.dart';
import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/models/service_model.dart';
import 'package:feelps/app/modules/map/errors/map_error.dart';
import 'package:feelps/app/modules/map/models/directions_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';

abstract class IMapRouteRepository {
  Future<Either<Failure, DirectionsModel>> getRoute(
      {required String serviceId});
}

class MapRouteRepository implements IMapRouteRepository {
  final FirebaseDatabase _database;
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  static const String apikey = 'AIzaSyCEwNIYKlBVix67Im1MVTMWLGMg7vfK8d4';

  final ConnectivityService _connectivityService;
  final String tableName = 'service-${appFlavor!.title}';
  final Dio _dio;

  MapRouteRepository(this._database, this._connectivityService, this._dio);

  @override
  Future<Either<Failure, DirectionsModel>> getRoute(
      {required String serviceId}) async {
    @override
    final result = await _connectivityService.isOnline;
    if (result.isLeft()) {
      //TODO:return result;
    }
    final reference = _database.reference();

    try {
      final service = ServiceModel.fromMap(Map<String, dynamic>.from(
          (await reference.child(tableName).child(serviceId.toString()).once())
              .value as Map));
      final currentLocation = await Location().getLocation();

      final mapResponse = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${currentLocation.latitude},${currentLocation.longitude}',
          'destination':
              '${service.deliveryAddress.latitude},${service.deliveryAddress.longitude}',
          'key': apikey,
        },
      );
      if (mapResponse.statusCode == 200) {
        return Right(
            DirectionsModel.fromMap(mapResponse.data as Map<String, dynamic>));
      } else {
        return Left(GetDirectionsInfoError(
            title: "Não foi possível continuar",
            message: 'Ocorreu um erro ao buscar os dados da entrega.'));
      }
    } catch (e) {
      return Left(GetDirectionsInfoError(
          title: "Não foi possível continuar",
          message: 'Ocorreu um erro ao buscar os dados da entrega.'));
    }
  }
}
