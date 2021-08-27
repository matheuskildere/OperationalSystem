import 'dart:async';

import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_images.dart';
import 'package:feelps/app/core/theme/app_typography.dart';
import 'package:feelps/app/core/utils/app_parameters.dart';
import 'package:feelps/app/modules/map/models/pin_information.dart';
import 'package:feelps/app/modules/map/presenter/controller/map_route_controller.dart';
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
  LocationData? startLocation;
  LocationData? currentLocation;
  LocationData? destinationLocation;
  late Location location;
  List<LatLng> polylineCoordinates = [];
  final Set<Marker> _markers = <Marker>{};
  final Completer<GoogleMapController> _controller = Completer();

  final controller = Modular.get<MapRouteController>();

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

  @override
  void initState() {
    location = Location();
    polylinePoints = PolylinePoints();

    controller.serviceId = widget.serviceId;

    // getLocation();
    location.changeSettings(
      interval: 5000,
    );
    Location().onLocationChanged.listen((event) async {
      currentLocation = event;

      updatePinOnMap();
      setState(() {});
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
      print(destinationLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: 18,
        tilt: 50,
        bearing: 30,
        target: LatLng(-26.910421537584813, -49.092771326985265));
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        zoom: 18,
        tilt: 50,
        bearing: 30,
      );
    }
    return Scaffold(
      body: Observer(builder: (context) {
        if (controller.dialogData != null) {
          return Container(
            width: 332,
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
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                    strokeWidth: 6,
                  )));
        }
        return Stack(
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
                controllerMap.setMapStyle(Utils.mapStyles);
                _controller.complete(controllerMap);
                showPinsOnMap();
              },
              zoomControlsEnabled: false,
            )
          ],
        );
      }),
    );
  }

  Future<void> showPinsOnMap() async {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    // final pinPosition =
    //     LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    // get a LatLng out of the LocationData object
    final destPosition =
        LatLng(destinationLocation!.latitude!, destinationLocation!.longitude!);

    _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: destPosition,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0),
            AppImages.establishmentLocation)));
    // _markers.add(
    //   Marker(
    //       markerId: MarkerId('location'),
    //       position: pinPosition,
    //   icon: await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 2.0),
    //         AppImages.establishmentLocation)));
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
          color: AppColors.primary,
          width: 7,
          points: polylineCoordinates));
      print(_polylines);
      setState(() {});
    }
  }

  Future<void> updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    final CameraPosition cPosition = CameraPosition(
      zoom: 18,
      tilt: 50,
      bearing: 30,
      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    final pinPosition =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    //sourcePinInfo.location = pinPosition;

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
