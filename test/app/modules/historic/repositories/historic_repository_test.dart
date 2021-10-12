import 'package:dartz/dartz.dart';
import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_database_mock/firebase_database_mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:feelps/app/core/flavors/app_flavors.dart';
import 'package:feelps/app/core/services/connectivity_service.dart';
import 'package:feelps/app/modules/historic/repositories/historic_repository.dart';

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
    appFlavor = Flavor.prod;
    repository = HistoricRepository(connectivityService, firebaseDatabase);

    // initialize locale to convert String to Datetime
    await initializeDateFormatting('p t_BR');

    when(() => connectivityService.isOnline)
        .thenAnswer((_) async => Right(unit));

    MockFirebaseDatabase.instance.reference().set(database);
  });

  test('Get list of services entities', () async {
    final resultServices = await repository.getHistoric('0');

    expect(resultServices.fold(id, id), isA<List<ServiceEntity>>());
  });
}

final database = {
  'deliveryman-Develop': {
    '0': {
      'servicesHistory': ['service1']
    }
  },
  'services-Develop': {
    'service1': {
      "id": "service1",
      "dateInit": "2020-08-27 0:00",
      "dateEnd": "2020-08-27 0:00",
      "serviceName": "Legal",
      "price": 10.0,
      "status": "a caminho",
      "contactNumber": "9492",
      "deliveryAddress": {
        "receiver": "user receiver",
        "address": "delivery",
        "latitude": -6.0734862262354845,
        "longitude": -49.89554485547499
      },
      "deliveryMan": {
        "id": "0",
        "fullName": "user",
        "notificationToken": "ashkdjasdkasd",
        "location": {
          "latitude": -6.0734862262354845,
          "longitude": -49.89554485547499
        }
      },
      "establishment": {
        "id": "1",
        "name": "esta",
        "address": "address",
        "location": {
          "latitude": -6.0734862262354845,
          "longitude": -49.89554485547499
        }
      }
    }
  }
};
