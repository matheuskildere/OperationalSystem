import 'package:feelps/app/core/entities/service_entity.dart';
import 'package:feelps/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final ServiceEntity service;
  bool isClicked;

  ExpandableContainer({required this.service, this.isClicked = false});
  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            (widget.isClicked)
                ? widget.isClicked = false
                : widget.isClicked = true;
          });
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 126,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://juristas.com.br/wp-content/uploads/2020/01/iStock-1144136008-300x202.jpg'),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.service.deliveryMan.fullName,
                                    style: AppTypography.buttonText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.service.dateInit.toString(),
                                    style: AppTypography.labelText
                                        .copyWith(fontSize: 10.5),
                                  )
                                ],
                              )
                            ],
                          ),
                          Text(
                            widget.service.serviceName,
                            style:
                                AppTypography.buttonText.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 6.5,
                                backgroundColor:
                                    widget.service.status == 'Cancelado'
                                        ? AppColors.error
                                        : AppColors.success,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.service.status,
                                style: AppTypography.cardText.copyWith(
                                    fontSize: 10.5,
                                    color: widget.service.status == 'Cancelado'
                                        ? AppColors.error
                                        : AppColors.success),
                              ),
                            ],
                          ),
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
              if (widget.isClicked)
                Container()
              else
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 34,
                      ),
                      Text('Endereço de Retirada:',
                          textAlign: TextAlign.start,
                          style:
                              AppTypography.buttonText.copyWith(fontSize: 12)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.service.establishment.address,
                          style: AppTypography.cardText.copyWith(fontSize: 12)),
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
                          style: AppTypography.cardText.copyWith(fontSize: 12)),
                      SizedBox(
                        height: 31,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(5)),
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
                                      style: AppTypography.cardText.copyWith(
                                          fontSize: 10.5,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(5)),
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Text(
                                      'Cartão',
                                      style: AppTypography.cardText.copyWith(
                                          fontSize: 10.5,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Row(
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
                                      'Tempo de corrida: 15 min',
                                      style: AppTypography.cardText.copyWith(
                                          fontSize: 10.5,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
