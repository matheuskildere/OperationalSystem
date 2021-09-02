import 'dart:async';

import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/app_icons.dart';
import 'package:feelps/app/core/theme/app_images.dart';
import 'package:feelps/app/core/theme/app_typography.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:feelps/app/modules/historic/presenter/components/expandable_container.dart';
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
  final pagecontroller = Modular.get<HistoricController>();
  bool isSmall = false;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    pagecontroller.serviceId = widget.service.id;
    getDirections();

    super.initState();
  }

  Future getDirections() async {
    await pagecontroller.getDirections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            polylines: {
              (Polyline(
                  polylineId: PolylineId('poly'),
                  color: AppColors.secondary,
                  width: 7,
                  points: pagecontroller.directions!.polylinepoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList()))
            },
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
            onMapCreated: (GoogleMapController controllerMap) async {
              controllerMap.setMapStyle(Utils.mapStyles);
              _controller.complete(controllerMap);
              await addmarkers();
              await pagecontroller.getDirections().then((value) {
                controllerMap.animateCamera(CameraUpdate.newLatLngBounds(
                    pagecontroller.directions!.bounds, 100));
              });
              setState(() {});
              // showModalBottomSheet(
              //     context: context,
              //     builder: (context) {
              //       return BottomSheet(
              //         builder: (
              //           context,
              //         ) {
              //           return GestureDetector(
              //             onVerticalDragDown: (details) {
              //               print('aquiiiiiiii');
              //               isSmall = !isSmall;
              //               setState(() {});
              //             },
              //             child: AnimatedContainer(
              //               duration: Duration(milliseconds: 500),
              //               child: contentColumn(),
              //             ),
              //           );
              //         },
              //         onClosing: () {},
              //       );
              // });
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
          GestureDetector(
            child: ExpandableContainer(
              service: widget.service,
              isClicked: true,
              fromdetail: true,
            ),
          ),
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
            AppImages.establishmentLocation)));
    _markers.add(Marker(
        markerId: MarkerId('destination'),
        position: LatLng(widget.service.deliveryAddress.latitude,
            widget.service.deliveryAddress.longitude),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0),
            AppImages.deliveryManLocation)));
  }

  Widget contentColumn() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                                    fontSize: 12, color: AppColors.greyText)),
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Endereço de Retirada:',
                        textAlign: TextAlign.start,
                        style: AppTypography.buttonText.copyWith(fontSize: 12)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.service.establishment.address,
                        style: AppTypography.cardText
                            .copyWith(fontSize: 12, color: AppColors.greyText)),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Endereço de Entrega:',
                        style: AppTypography.buttonText.copyWith(fontSize: 12)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.service.deliveryAddress.adress,
                        style: AppTypography.cardText
                            .copyWith(fontSize: 12, color: AppColors.greyText)),
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
