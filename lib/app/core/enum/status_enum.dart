enum DeliveryStatusEnum {
  serchingDeliveryMan,
  accepted,
  wayToPickup,
  pickedUp,
  waytoDeliver,
  completed,
}

extension DeliveryStatusExt on DeliveryStatusEnum {
  String getString() {
    switch (this) {
      case DeliveryStatusEnum.serchingDeliveryMan:
        return "Procurando entregador";
      case DeliveryStatusEnum.accepted:
        return "Aceito";
      case DeliveryStatusEnum.wayToPickup:
        return "A caminho da retirada";
      case DeliveryStatusEnum.pickedUp:
        return "Retirado";
      case DeliveryStatusEnum.waytoDeliver:
        return "A caminho da entrega";
      case DeliveryStatusEnum.completed:
        return "Finalizado";

      default:
        return "Ocorreu um erro";
    }
  }
}
