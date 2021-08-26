import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/modules/map/presenter/controller/map_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRoutePage extends StatefulWidget {
  final String? serviceId;
  const MapRoutePage({required this.serviceId});

  @override
  _MapRoutePageState createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  static CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-3.091256, -60.018891),
    zoom: 14.4746,
  );
  late GoogleMapController mapController;
  final controller = Modular.get<MapRouteController>();

  @override
  void initState() {
    controller.serviceId = widget.serviceId;
    getLocation();

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
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onTap: (argument) {},
              onCameraMove: (position) {
                setState(() {});
              },
              onCameraMoveStarted: () {
                setState(() {});
              },
              initialCameraPosition: _initialCameraPosition,
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
      floatingActionButton: InkWell(
        onTap: () async {
          await controller.getDirections();
          mapController.animateCamera(
              CameraUpdate.newLatLngBounds(controller.directions!.bounds, 100));
          setState(() {});
        },
        child: Container(
          height: 46,
          width: 174,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF434343)),
          child: Center(
              child: Text(
            "Iniciar",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}
