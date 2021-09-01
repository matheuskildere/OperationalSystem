import 'dart:async';

import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_images.dart';
import 'package:feelps/app/core/utils/app_parameters.dart';
import 'package:feelps/app/modules/map/presenter/pages/map_route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryDetailPage extends StatefulWidget {
  final ServiceEntity service;

  const DeliveryDetailPage({required this.service});

  @override
  _DeliveryDetailPageState createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = <Marker>{};
  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  final Set<Polyline> _polylines = <Polyline>{};

  @override
  void initState() {
    polylinePoints = PolylinePoints();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            polylines: _polylines,
            markers: _markers,
            onCameraMove: (position) {
              setState(() {});
            },
            onCameraMoveStarted: () {
              setState(() {});
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.service.establishment.location.latitude,
                    widget.service.establishment.location.longitude)),
            onMapCreated: (GoogleMapController controllerMap) {
              controllerMap.setMapStyle(Utils.mapStyles);
              _controller.complete(controllerMap);
              setState(() {});
            },
          ),
          Positioned(
            left: 15,
            top: 50,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 4),
                      borderRadius: BorderRadius.circular(33)),
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 16.5,
                    child: AppIcon(
                      icon: AppIcons.arrowBack,
                      color: AppColors.white,
                    ),
                  )),
            ),
          )
        ],
      ),
      // bottomSheet: BottomSheet(onClosing: onClosing, builder: builder),
    );
  }

  Future<void> showPinsOnMap() async {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    // final pinPosition =
    //     LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    // get a LatLng out of the LocationData object
    final destPosition = LatLng(widget.service.deliveryAddress.latitude,
        widget.service.deliveryAddress.longitude);

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
            PointLatLng(widget.service.establishment.location.latitude,
                widget.service.establishment.location.longitude),
            PointLatLng(widget.service.deliveryAddress.latitude,
                widget.service.deliveryAddress.longitude));

    if (result.status == 'OK' && result.points.isNotEmpty) {
      for (final point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      _polylines.add(Polyline(
          polylineId: PolylineId('poly'),
          color: AppColors.secondary,
          width: 7,
          points: polylineCoordinates));
      final GoogleMapController controller = await _controller.future;
      // controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, padding));
      setState(() {});
    }
  }
}
