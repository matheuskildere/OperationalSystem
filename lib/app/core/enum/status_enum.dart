enum DeliveryStatusEnum {
  serchingDeliveryMan,
  accepted,
  wayToPickup,
  pickedUp,
  waytoDeliver,
  completed,
  canceled,
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
      case DeliveryStatusEnum.canceled:
        return "Cancelado";
      default:
        return "Ocorreu um erro";
    }
  }

  static DeliveryStatusEnum getByString(String group) {
    switch (group) {
      case "Procurando entregador":
        return DeliveryStatusEnum.serchingDeliveryMan;
      case "Aceito":
        return DeliveryStatusEnum.accepted;
      case "A caminho da retirada":
        return DeliveryStatusEnum.wayToPickup;
      case "Retirado":
        return DeliveryStatusEnum.pickedUp;
      case "A caminho da entrega":
        return DeliveryStatusEnum.waytoDeliver;
      case "Finalizado":
        return DeliveryStatusEnum.completed;
      case "Cancelado":
        return DeliveryStatusEnum.canceled;
      default:
        return DeliveryStatusEnum.serchingDeliveryMan;
    }
  }

  String getButtonTitle() {
    switch (this) {
      case DeliveryStatusEnum.wayToPickup:
        return "Confirmar retirada";
      case DeliveryStatusEnum.waytoDeliver:
        return "Finalizar";
      default:
        return "Finalizar";
    }
  }

  DeliveryStatusEnum getNext() {
    switch (this) {
      case DeliveryStatusEnum.wayToPickup:
        return DeliveryStatusEnum.waytoDeliver;
      case DeliveryStatusEnum.waytoDeliver:
        return DeliveryStatusEnum.completed;
      default:
        return DeliveryStatusEnum.completed;
    }
  }
}
