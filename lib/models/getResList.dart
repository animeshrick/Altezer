class GetRestShopList {
  GetRestShopList({
    required this.message,
    required this.status,
    required this.restList,
  });

  final String message;
  final String status;
  final List<RestShopList> restList;

  factory GetRestShopList.fromJson(Map<String, dynamic> json) =>
      GetRestShopList(
        message: json["message"],
        status: json["status"],
        restList: List<RestShopList>.from(
            json["RestList"].map((x) => RestShopList.fromJson(x))),
      );
}

class RestShopList {
  RestShopList({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantType,
    required this.restaurantAddress,
    required this.reservationCode,
    required this.phone,
    required this.mainImage,
    required this.deliveryFee,
    required this.deliveryInfo,
    required this.restaurantEthnic,
    required this.logoImageFile,
    required this.clientId,
    required this.logoImageFile2,
    required this.parish,
    required this.parishId,
    required this.menuCount,
  });

  final int restaurantId;
  final String restaurantName;
  final String restaurantType;
  final String? restaurantAddress;
  final String reservationCode;
  final String phone;
  final String mainImage;
  final String? deliveryFee;
  final String deliveryInfo;
  final String restaurantEthnic;
  final String logoImageFile;
  final int clientId;
  final String logoImageFile2;
  final String? parish;
  final int parishId;
  final int menuCount;

  factory RestShopList.fromJson(Map<String, dynamic> json) => RestShopList(
      restaurantId: json["Restaurant_ID"],
      restaurantName: json["Restaurant_Name"],
      restaurantType: json["Restaurant_Type"],
      restaurantAddress: json["Restaurant_Address"],
      reservationCode: json["Reservation_Code"],
      phone: json["Phone"],
      mainImage: json["MainImage"],
      deliveryFee: json["delivery_Fee"],
      deliveryInfo: json["Delivery_Info"],
      restaurantEthnic: json["Restaurant_Ethnic"],
      logoImageFile: json["Logo_Image_File"],
      clientId: json["Client_Id"],
      logoImageFile2: json["Logo_Image_File2"],
      parish: json["Parish"],
      parishId: json["Parish_ID"],
      menuCount: json["menu_count"]);
}
