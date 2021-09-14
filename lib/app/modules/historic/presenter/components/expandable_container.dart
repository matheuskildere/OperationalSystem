import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/enum/status_enum.dart';
import 'package:feelps/app/core/theme/app_colors.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:feelps/app/core/utils/app_columns.dart';
import 'package:feelps/app/core/utils/data_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExpandableContainer extends StatefulWidget {
  final ServiceEntity service;
  final bool isClicked;

  const ExpandableContainer({required this.service, this.isClicked = false});
  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  late bool isClicked = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isClicked = widget.isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isClicked = !isClicked;
          });
        },
        child: SizedBox(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: AppColumns.column6(context: context),
                                child: Text(
                                  widget.service.serviceName,
                                  style: AppTypography.buttonText
                                      .copyWith(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                  isClicked
                                      ? widget.service.establishment.name
                                      : '',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.cardText.copyWith(
                                      fontSize: 12, color: AppColors.greyText)),
                            ],
                          ),
                        ],
                      ),
                      Flexible(
                        child: Column(
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
                                  width: 50,
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
                            Text(
                              'R\$${widget.service.price.toStringAsFixed(2)}',
                              style: AppTypography.cardText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isClicked)
                Container()
              else
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Endereço de Retirada:',
                              textAlign: TextAlign.start,
                              style: AppTypography.buttonText
                                  .copyWith(fontSize: 12)),
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
                              style: AppTypography.buttonText
                                  .copyWith(fontSize: 12)),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Modular.to.pushNamed(AppRoutes.detail,
                                        arguments: widget.service);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                5)),
                                    padding: EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          icon: AppIcons.map,
                                          color: AppColors.white,
                                          height: 13,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Ver no mapa',
                                          style: AppTypography.cardText
                                              .copyWith(
                                                  fontSize: 10.5,
                                                  color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
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
                                    Text(
                                      "Tempo de corrida: ${DateParser.getTimeOfService(start: widget.service.dateInit!, end: widget.service.dateEnd!)} min",
                                      style: AppTypography.cardText.copyWith(
                                          fontSize: 10.5,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                              ),
                              RotatedBox(
                                  quarterTurns: 1,
                                  child: AppIcon(
                                    icon: AppIcons.arrowBackIOS,
                                    color: Colors.black,
                                    height: 18,
                                    fit: BoxFit.fitHeight,
                                    onTap: () {
                                      setState(() {
                                        isClicked = false;
                                      });
                                    },
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}