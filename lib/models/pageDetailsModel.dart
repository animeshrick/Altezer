class ProductDetails {
  ProductDetails({
    required this.message,
    required this.status,
    required this.productlist,
  });

  final String message;
  final String status;
  final List<Productlist> productlist;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        message: json["message"],
        status: json["status"],
        productlist: List<Productlist>.from(
            json["productlist"].map((x) => Productlist.fromJson(x))),
      );
}

class Productlist {
  Productlist({
    required this.productTypeId,
    required this.yjProductId,
    required this.productName,
    required this.productFullName,
    required this.productImageUrl,
    required this.price,
    required this.productUrl,
    required this.sellerName,
    required this.sellerNameMobile,
    required this.productCategoryId,
    required this.productCategorySub1Id,
    required this.productCategorySub2Id,
    required this.inStockOrOutOfStock,
    required this.inStock,
    required this.clientId,
    required this.allowOnlineOrder,
    required this.displayPriceFlag,
    required this.perks,
    required this.isMadeToOrder,
    required this.size,
    required this.avaRating,
    required this.ratingCount,
  });

  final String productTypeId;
  final int yjProductId;
  final String? productName;
  final String? productFullName;
  final String? productImageUrl;
  final String? price;
  final String? productUrl;
  final String? sellerName;
  final String? sellerNameMobile;
  final int productCategoryId;
  final int productCategorySub1Id;
  final int productCategorySub2Id;
  final String inStockOrOutOfStock;
  final int inStock;
  final int clientId;
  final String allowOnlineOrder;
  final String displayPriceFlag;
  final String perks;
  final int isMadeToOrder, avaRating, ratingCount;
  final String size;

  factory Productlist.fromJson(Map<String, dynamic> json) => Productlist(
        productTypeId: json["ProductTypeId"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productFullName: json["Product_FullName"],
        productImageUrl: json["Product_Image_URL"],
        price: json["Price"],
        productUrl: json["Product_url"],
        sellerName: json["Seller_Name"],
        sellerNameMobile: json["Seller_Name_Mobile"],
        productCategoryId: json["Product_Category_ID"],
        productCategorySub1Id: json["Product_Category_Sub1_ID"],
        productCategorySub2Id: json["Product_Category_Sub2_ID"],
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"],
        inStock: json["in_stock"],
        clientId: json["client_id"],
        allowOnlineOrder: json["allow_online_order"],
        displayPriceFlag: json["Display_Price_Flag"],
        perks: json["Perks"],
        isMadeToOrder: json["is_Made_To_Order"],
        size: json["Size"],
        avaRating: json['AverageRating'],
        ratingCount: json['RatingCount'],
      );
}
