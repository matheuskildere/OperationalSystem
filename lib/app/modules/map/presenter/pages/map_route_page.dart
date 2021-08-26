import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/modules/map/presenter/controller/map_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapRoutePage extends StatefulWidget {
  final String? serviceId;
  const MapRoutePage({required this.serviceId});

  @override
  _MapRoutePageState createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  late CameraPosition? _initialCameraPosition;
  late GoogleMapController mapController;
  final controller = Modular.get<MapRouteController>();

  @override
  void initState() {
    controller.serviceId = widget.serviceId;

    getLocation();
    Location().changeSettings(
      interval: 5000,
    );
    Location().onLocationChanged.listen((event) {
      controller.locationData = event;
      controller.getDirections();
      CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(event.latitude!, event.longitude!)));
      setState(() {});
    });

    super.initState();
  }

  Future<void> getLocation() async {
    _initialCameraPosition = await controller.initialLocation();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Observer(builder: (context) {
            return GoogleMap(
              polylines: {
                if (controller.directions != null)
                  Polyline(
                      polylineId: PolylineId('first'),
                      color: AppColors.error,
                      width: 5,
                      points: controller.directions!.polylinepoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList())
              },
              markers: {
                if (controller.directions != null)
                  Marker(
                      markerId: MarkerId('destination'),
                      position: LatLng(
                          controller.directions!.polylinepoints.last.latitude,
                          controller
                              .directions!.polylinepoints.last.longitude)),
                if (controller.locationData != null)
                  Marker(
                      markerId: MarkerId('location'),
                      position: LatLng(controller.locationData!.latitude!,
                          controller.locationData!.longitude!)),
              },
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onTap: (argument) {},
              onCameraMove: (position) {
                setState(() {});
              },
              onCameraMoveStarted: () {
                setState(() {});
              },
              initialCameraPosition: _initialCameraPosition!,
              onMapCreated: (GoogleMapController controllerMap) async {
                mapController = controllerMap;

                setState(() {});
                await controller.getDirections().then((value) {
                  mapController.animateCamera(CameraUpdate.newLatLngBounds(
                      controller.directions!.bounds, 100));
                });
                setState(() {});
              },
              zoomControlsEnabled: false,
            );
          }),
        ],
      ),
    );
  }
}
