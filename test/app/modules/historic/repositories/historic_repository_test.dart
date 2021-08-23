import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mock/firebase_database_mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/repositories/historic_repository.dart';

class FirebaseDatabaseMock extends Mock implements FirebaseDatabase {
  static final FirebaseDatabase _instance = FirebaseDatabase();
  static FirebaseDatabase get instance => _instance;
}

class ConnectivityServiceMock extends Mock implements ConnectivityService {}

class DataSnapshotMock extends Mock implements DataSnapshot {
  final String? key;
  final dynamic value;
  DataSnapshotMock({
    this.key,
    required this.value,
  });
}

void main() {
  late FirebaseDatabase firebaseDatabase;
  final connectivityService = ConnectivityServiceMock();
  late HistoricRepository repository;

  setUp(() async {
    firebaseDatabase = MockFirebaseDatabase.instance;
    appFlavor = Flavor.dev;
    repository = HistoricRepository(
    connectivityService, firebaseDatabase);

    when(()=> connectivityService.isOnline).thenAnswer((_) async => Right(unit));

    MockFirebaseDatabase.instance.reference().set(mockDataResponse);
  });

  test('Get list of services entities', () async {
    final resultServices = await repository.getHistoric('0');

    expect(resultServices.fold(id, id), isA<List<ServiceEntity>>());
  });
}

  final responseListSucess = DataSnapshotMock(
    value: ['service1']);

  // final responseServiceSucess = DataSnapshotMock(
  //   value: );

  final mockDataResponse = {
    'deliveryman-dev': {
      '0': {
        'servicesHistory': ['service1']
      }
    },
    'services-dev': {
      'service1': {
        "id": "service1",
        "date_init": "1980-08-27 0:00",
        "date_end": "1980-08-27 0:00",
        "serviceName": "Legal",
        "price": 10.0,
        "status": "a caminho",
        "contactNumber": "9492",
        "pickupAddress": {
            "address": "local",
            "latitude": -6.0734862262354845,
            "longitude": -49.89554485547499
        },
        "deliveryAddress":  {
            "address": "delivery",
            "latitude": -6.0734862262354845,
            "longitude": -49.89554485547499
        },
        "deliveryMan": {
            "id": "0",
            "fullName": "user",
            "location": {
              "latitude": -6.0734862262354845,
              "longitude": -49.89554485547499
            }
        },
        "establishment": {
            "id": "1",
            "name": "esta"
        }
      }
    }
  };