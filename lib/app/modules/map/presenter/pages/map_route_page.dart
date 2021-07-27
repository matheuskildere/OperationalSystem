import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRoutePage extends StatefulWidget {
  const MapRoutePage({Key? key}) : super(key: key);

  @override
  _MapRoutePageState createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-30.0277, -51.2287),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(builder: (context) {
          return GoogleMap(
            //markers: controller.markers,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onTap: (argument) {
              //controller.selectedEstablishment = null;
            },
            onCameraMove: (position) {
              setState(() {});
            },
            onCameraMoveStarted: () {
              setState(() {});
            },
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controllerMap) async {
              //controller.mapController.complete(controllerMap);
              setState(() {});
            },
            zoomControlsEnabled: false,
          );
        }),
      ],
    );
  }
}
