// import 'package:feelps/app/core/theme/theme.dart';
// import 'package:feelps/app/core/utils/app_columns.dart';
// import 'package:feelps/app/core/utils/formatter.dart';
// import 'package:flutter/material.dart';

// import 'package:asuka/asuka.dart' as asuka;

// import '../components.dart';

// class AlertDialogService extends StatefulWidget {
//   final double value;
//   final String distance;
//   final String pickupAddress;
//   final String deliveryAddress;
//   const AlertDialogService({ Key? key,
//       required this.value,
//       required this.distance,
//       required this.pickupAddress,
//       required this.deliveryAddress,
//       this.barrierDismissible = false
//   }) : super(key: key);

//   @override
//   _AlertDialogServiceState createState() => _AlertDialogServiceState();
// }

// class _AlertDialogServiceState extends State<AlertDialogService> {
//   @override
//   void initState() {
//     super.initState();
//     showDialog();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   showDialog(){
//     asuka.showDialog(
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//             insetPadding: EdgeInsets.all(33),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       AppIcon(
//                         icon: AppIcons.deliveryDiningRounded,
//                         color: AppColors.secondary,
//                         width: 35,
//                         fit: BoxFit.cover,
//                         height: 35,
//                       ),
//                       SizedBox(
//                         width: 6,
//                       ),
//                       Flexible(
//                         child: Text(
//                           "Nova corrida avistada!",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(color: AppColors.black),
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 41),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Valor: ${Formatter.moneySettings(value.toString())}",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.black, fontSize: 18),
//                           textAlign: TextAlign.start,
//                         ),
//                         const SizedBox(height: 3,),
//                         Text(
//                           "Distância: $distance",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.black, fontSize: 18),
//                           textAlign: TextAlign.start,
//                         ),
//                         const SizedBox(height: 24,),
//                         Text(
//                           "Retirada",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.black, fontSize: 18),
//                           textAlign: TextAlign.start,
//                         ),
//                         SizedBox(
//                           width: 63,
//                           child: Divider(
//                             color: AppColors.secondary,
//                             thickness: 3,
//                           ),
//                         ),
//                         const SizedBox(height: 9,),
//                         Text(
//                           pickupAddress,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.black, fontSize: 15),
//                           textAlign: TextAlign.start,
//                         ),
//                         const SizedBox(height: 12,),
//                         Text(
//                           "Entrega",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.black, fontSize: 18),
//                           textAlign: TextAlign.start,
//                         ),
//                         SizedBox(
//                           width: 63,
//                           child: Divider(
//                             color: AppColors.secondary,
//                             thickness: 3,
//                           ),
//                         ),
//                         const SizedBox(height: 9,),
//                         Text(
//                           deliveryAddress,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: AppColors.black, fontSize: 15),
//                           textAlign: TextAlign.start,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 17,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: AppColumns.column4(context: context),
//                         child: DefaultButton(
//                           title: "Recusar (60s)",
//                           invertColors: true,
//                           smallTitle: true,
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                       SizedBox(width: AppColumns.column4(context: context),
//                         child: DefaultButton(
//                           title: "Aceitar",
//                           smallTitle: true,
//                           successColor: true,
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//           ));
//   }
// }