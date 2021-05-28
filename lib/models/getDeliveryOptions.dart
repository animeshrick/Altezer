import 'dart:convert';

DeliveryOptionModel deliveryOptionModelFromJson(String str) =>
    DeliveryOptionModel.fromJson(json.decode(str));

class DeliveryOptionModel {
  DeliveryOptionModel({
    required this.message,
    required this.status,
    required this.deliveryOptions,
  });

  final String message;
  final String status;
  final List<DeliveryOption> deliveryOptions;

  factory DeliveryOptionModel.fromJson(Map<String, dynamic> json) =>
      DeliveryOptionModel(
        message: json["message"],
        status: json["status"],
        deliveryOptions: List<DeliveryOption>.from(
            json["deliveryOptions"].map((x) => DeliveryOption.fromJson(x))),
      );
}

class DeliveryOption {
  DeliveryOption({
    required this.deliveryId,
    required this.deliveryName,
  });

  final int deliveryId;
  final String deliveryName;

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
        deliveryId: json["code_id"],
        deliveryName: json["Long_name"],
      );
}
