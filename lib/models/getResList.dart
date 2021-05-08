// import 'dart:convert';
//
// GetRestList getRestListFromJson(String str) =>
//     GetRestList.fromJson(json.decode(str));
//
// class GetRestList {
//   GetRestList({
//     required this.message,
//     required this.status,
//     required this.restList,
//   });
//
//   final String message;
//   final String status;
//   final List<RestList> restList;
//
//   factory GetRestList.fromJson(Map<String, dynamic> json) => GetRestList(
//         message: json["message"],
//         status: json["status"],
//         restList: List<RestList>.from(
//             json["RestList"].map((x) => RestList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "RestList": List<dynamic>.from(restList.map((x) => x.toJson())),
//       };
// }
//
// class RestList {
//   RestList({
//     required this.restaurantId,
//     required this.restaurantName,
//     required this.restaurantType,
//     required this.restaurantAddress,
//     required this.reservationCode,
//     required this.phone,
//     required this.mainImage,
//     required this.deliveryFee,
//     required this.deliveryInfo,
//     required this.restaurantEthnic,
//     required this.logoImageFile,
//     required this.clientId,
//     required this.logoImageFile2,
//     required this.parish,
//     required this.parishId,
//     required this.menuCount,
//   });
//
//   final int restaurantId;
//   final String restaurantName;
//   final String restaurantType;
//   final dynamic restaurantAddress;
//   final ReservationCode reservationCode;
//   final String phone;
//   final String mainImage;
//   final String deliveryFee;
//   final DeliveryInfo deliveryInfo;
//   final String restaurantEthnic;
//   final LogoImageFile logoImageFile;
//   final int clientId;
//   final LogoImageFile logoImageFile2;
//   final dynamic parish;
//   final int parishId;
//   final int menuCount;
//
//   factory RestList.fromJson(Map<String, dynamic> json) => RestList(
//       restaurantId: json[''],
//       restaurantName: json[''],
//       restaurantType: json[''],
//       restaurantAddress: json[''],
//       reservationCode: json[''],
//       phone: json[''],
//       mainImage: json[''],
//       deliveryFee: json[''],
//       deliveryInfo: json[''],
//       restaurantEthnic: json[''],
//       logoImageFile: json[''],
//       clientId: json[''],
//       logoImageFile2: json[''],
//       parish: json[''],
//       parishId: json[''],
//       menuCount: json['']);
// }
