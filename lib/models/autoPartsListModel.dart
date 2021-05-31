class GetAutoPartsList {
  GetAutoPartsList({
    required this.message,
    required this.status,
    required this.autoPartsList,
  });

  final String message;
  final String status;
  final List<AutoPartsList> autoPartsList;

  factory GetAutoPartsList.fromJson(Map<String, dynamic> json) => GetAutoPartsList(
        message: json["message"],
        status: json["status"],
        autoPartsList: List<AutoPartsList>.from(
            json["RestList"].map((x) => AutoPartsList.fromJson(x))),
      );
}

class AutoPartsList {
  AutoPartsList({
    required this.productTypeId,
    required this.yjProductId,
    required this.productName,
    required this.productFullName,
    required this.productImage,
    required this.productImageUrl,
    required this.price,
    required this.productUrl,
    required this.sellerName,
    required this.sellerNameMobile,
    required this.inStockOrOutOfStock,
    required this.clientId,
    required this.forSaleBy,
    required this.sellerName1,
    required this.brand,
    required this.description,
    required this.price1,
    required this.inStock,
    required this.clientLogoUrl,
    required this.allowOnlineOrder,
    required this.displayPriceFlag,
    required this.autoPartCategoryId,
    required this.perks,
    required this.isMadeToOrder,
    required this.size,
  });
  final String? productTypeId;
  final int yjProductId;
  final String? productName;
  final String? productFullName;
  final String? productImage;
  final String? productImageUrl;
  final String? price;
  final String? productUrl;
  final String? sellerName;
  final String? sellerNameMobile;
  final String? inStockOrOutOfStock;
  final int clientId;
  final String? forSaleBy;
  final String? sellerName1;
  final String? brand;
  final String? description;
  final double price1;
  final int inStock;
  final String? clientLogoUrl;
  final String? allowOnlineOrder;
  final String? displayPriceFlag;
  final int autoPartCategoryId;
  final String? perks;
  final int isMadeToOrder;
  final String? size;

  factory AutoPartsList.fromJson(Map<String, dynamic> json) => AutoPartsList(
        productTypeId: json["ProductTypeId"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productFullName: json["Product_FullName"],
        productImage: json["Product_Image"],
        productImageUrl: json["Product_Image_URL"],
        price: json["Price"],
        productUrl: json["Product_url"],
        sellerName: json["Seller_Name"],
        sellerNameMobile: json["Seller_Name_Mobile"],
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"],
        clientId: json["Client_Id"],
        forSaleBy: json["for_sale_by"],
        sellerName1: json["Seller_Name1"],
        brand: json["Product_url"],
        description: json["description"],
        price1: json["price1"],
        inStock: json["in_stock"],
        clientLogoUrl: json["client_logo_url"],
        allowOnlineOrder: json["allow_online_order"],
        displayPriceFlag: json["Display_Price_Flag"],
        autoPartCategoryId: json["Auto_Part_Category_id"],
        perks: json["Perks"],
        isMadeToOrder: json["is_Made_To_Order"],
        size: json["Size"],
      );
}
