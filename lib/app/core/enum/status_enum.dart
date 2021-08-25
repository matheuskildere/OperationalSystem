enum DeliveryStatusEnum {
  serchingDeliveryMan,
  accepted,
  wayToPickup,
  pickedUp,
  waytoDeliver,
  completed,
}

extension DeliveryStatusExt on DeliveryStatusEnum {
  String getDescription() {
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

  static DeliveryStatusEnum getByString(String group) {
    switch (group) {
      case "serchingDeliveryMan":
        return DeliveryStatusEnum.serchingDeliveryMan;
      case "accepted":
        return DeliveryStatusEnum.accepted;
      case "wayToPickup":
        return DeliveryStatusEnum.wayToPickup;
      case "pickedUp":
        return DeliveryStatusEnum.pickedUp;
      case "waytoDeliver":
        return DeliveryStatusEnum.waytoDeliver;
      case "completed":
        return DeliveryStatusEnum.completed;
      default:
        return DeliveryStatusEnum.serchingDeliveryMan;
    }
  }

  String getString() {
    switch (this) {
      case DeliveryStatusEnum.serchingDeliveryMan:
        return "serchingDeliveryMan";
      case DeliveryStatusEnum.accepted:
        return "accepted";
      case DeliveryStatusEnum.wayToPickup:
        return "wayToPickup";
      case DeliveryStatusEnum.pickedUp:
        return "pickedUp";
      case DeliveryStatusEnum.waytoDeliver:
        return "waytoDeliver";
      case DeliveryStatusEnum.completed:
        return "completed";
      default:
        return "serchingDeliveryMan";
    }
  }
}
