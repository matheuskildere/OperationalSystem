import 'dart:async';

import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_images.dart';
import 'package:feelps/app/core/theme/app_typography.dart';
import 'package:feelps/app/core/utils/app_parameters.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/historic/presenter/controller/historic_controller.dart';
import 'package:feelps/app/modules/map/presenter/pages/map_route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  final pagecontroller = Modular.get<HistoricController>();
  bool isSmall = false;

  late CameraPosition initialCamera;

  late double size = 350;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    pagecontroller.serviceId = widget.service.id;
    getDirections();
    initialCamera = CameraPosition(
        zoom: 14.5,
        target: LatLng(widget.service.establishment.location.latitude,
            widget.service.establishment.location.longitude));
    super.initState();
  }

  Future<void> getDirections() async {
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
      initialCamera =
          CameraPosition(zoom: 14.5, target: _polylines.first.points.last);
      setState(() {});
    }
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
            initialCameraPosition: initialCamera,
            onMapCreated: (GoogleMapController controllerMap) async {
              controllerMap.setMapStyle(Utils.mapStyles);
              _controller.complete(controllerMap);
              await addmarkers();
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: contentColumn(),
          )
        ],
      ),
    );
  }

  Future addmarkers() async {
    _markers.add(Marker(
        markerId: MarkerId('establishment'),
        position: LatLng(widget.service.establishment.location.latitude,
            widget.service.establishment.location.longitude),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0),
            AppImages.deliveryManLocation)));
    _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: LatLng(widget.service.deliveryAddress.latitude,
            widget.service.deliveryAddress.longitude),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0),
            AppImages.peopleLocation)));
  }

  Widget contentColumn() {
    return Container(
      color: AppColors.white,
      height: size,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                  height: 6,
                  width: 110,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4),
                    borderRadius: BorderRadius.circular(20),
                  )),
              SizedBox(
                height: 136,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.secondary,
                                backgroundImage: NetworkImage(
                                    widget.service.deliveryMan.photoUrl),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      widget.service.deliveryMan.fullName,
                                      style: AppTypography.buttonText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (widget.service.dateInit != null &&
                                      widget.service.dateEnd != null)
                                    Text(
                                      DateParser.getTimeInterval(
                                          start: widget.service.dateInit!,
                                          end: widget.service.dateEnd!),
                                      style: AppTypography.labelText
                                          .copyWith(fontSize: 10.5),
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (!isSmall)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.service.serviceName,
                                  style: AppTypography.buttonText
                                      .copyWith(fontSize: 12),
                                ),
                                Text(widget.service.establishment.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.cardText.copyWith(
                                        fontSize: 12,
                                        color: AppColors.greyText)),
                              ],
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 6.5,
                                backgroundColor: widget.service.status ==
                                        DeliveryStatusEnum.accepted
                                    ? AppColors.error
                                    : AppColors.success,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  widget.service.status.getDescription(),
                                  overflow: TextOverflow.fade,
                                  style: AppTypography.cardText.copyWith(
                                      fontSize: 10.5,
                                      color: widget.service.status ==
                                              DeliveryStatusEnum.accepted
                                          ? AppColors.error
                                          : AppColors.success),
                                ),
                              ),
                            ],
                          ),
                          if (!isSmall)
                            Text(
                              'R\$${widget.service.price.toStringAsFixed(2)}',
                              style: AppTypography.cardText,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (!isSmall)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Endereço de Retirada:',
                          textAlign: TextAlign.start,
                          style:
                              AppTypography.buttonText.copyWith(fontSize: 12)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.service.establishment.address,
                          style: AppTypography.cardText.copyWith(
                              fontSize: 12, color: AppColors.greyText)),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Endereço de Entrega:',
                          style:
                              AppTypography.buttonText.copyWith(fontSize: 12)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.service.deliveryAddress.adress,
                          style: AppTypography.cardText.copyWith(
                              fontSize: 12, color: AppColors.greyText)),
                      SizedBox(
                        height: 31,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius:
                                    BorderRadiusDirectional.circular(5)),
                            padding: EdgeInsets.all(4),
                            child: Row(
                              children: [
                                if (widget.service.dateInit != null &&
                                    widget.service.dateEnd != null)
                                  Text(
                                    "Tempo de corrida: ${DateParser.getTimeOfService(start: widget.service.dateInit!, end: widget.service.dateEnd!)} min",
                                    style: AppTypography.cardText.copyWith(
                                        fontSize: 10.5, color: AppColors.white),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
