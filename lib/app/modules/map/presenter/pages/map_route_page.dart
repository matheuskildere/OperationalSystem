import 'dart:async';

import 'package:feelps/app/core/entities/dialog_data_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_images.dart';
import 'package:feelps/app/core/theme/app_routes.dart';
import 'package:feelps/app/core/theme/app_typography.dart';
import 'package:feelps/app/core/utils/app_parameters.dart';
import 'package:feelps/app/modules/components/components.dart';
import 'package:feelps/app/modules/map/models/pin_information.dart';
import 'package:feelps/app/modules/map/presenter/components/change_status_component.dart';
import 'package:feelps/app/modules/map/presenter/components/observation_dialog.dart';
import 'package:feelps/app/modules/map/presenter/controller/map_route_controller.dart';
import 'package:feelps/app/modules/map/services/distance_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapRoutePage extends StatefulWidget {
  final String? serviceId;
  const MapRoutePage({required this.serviceId});

  @override
  _MapRoutePageState createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  // locations
  LocationData? startLocation;
  LocationData? currentLocation;
  LocationData? lastLocation;
  LocationData? destinationLocation;
  // to get location
  late Location location;
  // to create a Polyline route
  List<LatLng> polylineCoordinates = [];
  // markert to se locations
  final Set<Marker> _markers = <Marker>{};
  // map controller
  final Completer<GoogleMapController> _controller = Completer();

  final controller = Modular.get<MapRouteController>();
  // to calculate the distance
  final distanceCalculator = DistanceCalculator();
  double? distance;

  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;

  final Set<Polyline> _polylines = <Polyline>{};
  late PolylinePoints polylinePoints;

  bool seeButton = false;

  @override
  void initState() {
    location = Location();
    polylinePoints = PolylinePoints();

    controller.serviceId = widget.serviceId;

    // getLocation();
    location.changeSettings(
      interval: 5000,
    );
    location.onLocationChanged.listen((event) async {
      if (controller.serviceEntity!.status != DeliveryStatusEnum.completed &&
          controller.serviceEntity!.status != DeliveryStatusEnum.canceled) {
        currentLocation = event;
        updatePinOnMap();
        controller.updateLastLocation(
            latitude: event.latitude!, longitude: event.longitude!);
        if (polylineCoordinates.isNotEmpty) {
          distance =
              DistanceCalculator.distanceCalculatorByList(polylineCoordinates);
          print(distance);
          if (distance != null && distance! <= 0.150) {
            seeButton = true;
          } else {
            seeButton = false;
          }
        }
        setState(() {});
        controller.verifyServiceStatus();
      } else if (controller.dialogData != null) {
        await backToHome(dialog: controller.dialogData);
        controller.dialogData = null;
      }
    });

    setInitialLocationPickup();
    super.initState();
  }

  Future<void> setInitialLocationPickup() async {
    await controller.getService();
    if (controller.dialogData == null) {
      currentLocation = await location.getLocation();

      destinationLocation = LocationData.fromMap({
        "latitude": controller.serviceEntity!.establishment.location.latitude,
        "longitude": controller.serviceEntity!.establishment.location.longitude,
      });

      startLocation = LocationData.fromMap({
        "latitude": controller.serviceEntity!.deliveryMan.location.latitude,
        "longitude": controller.serviceEntity!.deliveryMan.location.longitude,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: 18.5,
        tilt: 30,
        bearing: 30,
        target: LatLng(-26.910421537584813, -49.092771326985265));
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        zoom: 18.5,
        tilt: 30,
        bearing: 30,
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Observer(builder: (context) {
          if (controller.dialogData != null) {
            return Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Center(
                  child: Text(
                    controller.dialogData!.description,
                    textAlign: TextAlign.center,
                    style: AppTypography.cardText,
                  ),
                ),
              ),
            );
          }
          if (controller.serviceEntity == null || destinationLocation == null) {
            return Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      color: AppColors.secondary,
                      strokeWidth: 6,
                    )));
          }
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  polylines: _polylines,
                  markers: _markers,
                  myLocationButtonEnabled: false,
                  onTap: (argument) {},
                  onCameraMove: (position) {
                    setState(() {});
                  },
                  onCameraMoveStarted: () {
                    setState(() {});
                  },
                  initialCameraPosition: initialCameraPosition,
                  onMapCreated: (GoogleMapController controllerMap) {
                    if (controller.serviceEntity!.status !=
                        DeliveryStatusEnum.canceled) {
                      controllerMap.setMapStyle(Utils.mapStyles);
                      _controller.complete(controllerMap);
                      showPinsOnMap();
                    }
                  },
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                      visible: seeButton,
                      child: ChangeStatusComponent(
                        title:
                            controller.serviceEntity!.status.getButtonTitle(),
                        onPressed: () async {
                          await ObservationDialog.showObservation(
                              onTap: (value, popAction) async {
                            await controller.updateStatus(value);
                            if (controller.serviceEntity!.status ==
                                DeliveryStatusEnum.waytoDeliver) {
                              destinationLocation = LocationData.fromMap({
                                "latitude": controller
                                    .serviceEntity!.deliveryAddress.latitude,
                                "longitude": controller
                                    .serviceEntity!.deliveryAddress.longitude,
                              });
                              final newDestPosition = LatLng(
                                  destinationLocation!.latitude!,
                                  destinationLocation!.longitude!);
                              _markers.removeWhere((element) =>
                                  element.markerId.value == 'destination');
                              _markers.add(Marker(
                                  markerId: MarkerId('destination'),
                                  position: newDestPosition,
                                  icon: await BitmapDescriptor.fromAssetImage(
                                      ImageConfiguration(devicePixelRatio: 2.0),
                                      AppImages.peopleLocation)));
                            }
                            popAction();
                            if (controller.serviceEntity!.status ==
                                DeliveryStatusEnum.completed) {
                              backToHome();
                            }
                          });
                        },
                      ),
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> backToHome({DialogDataEntity? dialog}) async {
    Modular.to.navigate(AppRoutes.home);
    DefaultAlertDialog.show(
        dialogData: dialog ??
            DialogDataEntity(
                title: "Parabêns",
                description: "Entrega realizada com sucesso!"));
  }

  Future<void> showPinsOnMap() async {
    // get a LatLng out of the LocationData object
    final destPosition =
        LatLng(destinationLocation!.latitude!, destinationLocation!.longitude!);

    _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: destPosition,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0),
            AppImages.establishmentLocation)));
    setPolylines();
  }

  Future<void> setPolylines() async {
    final PolylineResult result =
        await polylinePoints.getRouteBetweenCoordinates(
            AppParameters.apiGoogleMaps,
            PointLatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            PointLatLng(destinationLocation!.latitude!,
                destinationLocation!.longitude!));

    if (result.status == 'OK' && result.points.isNotEmpty) {
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      _polylines.add(Polyline(
          polylineId: PolylineId('poly'),
          color: AppColors.secondary,
          width: 7,
          points: polylineCoordinates));
      setState(() {});
    }
  }

  Future<void> updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    final CameraPosition cPosition = CameraPosition(
      zoom: 18.5,
      tilt: 30,
      bearing: 30,
      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    final pinPosition =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    // the trick is to remove the marker (by id)
    // and add it again at the updated location
    _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            //pinPillPosition = 0;
          });
        },
        position: pinPosition,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0),
            AppImages.deliveryManLocation)));
    polylineCoordinates.clear();
    setPolylines();
    setState(() {});
  }
}

class Utils {
  // ignore: leading_newlines_in_multiline_strings
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
