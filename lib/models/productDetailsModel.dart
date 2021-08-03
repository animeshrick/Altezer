class ProdDetailModel {
  ProdDetailModel({
    required this.message,
    required this.status,
    required this.details,
    required this.productReview,
    required this.relatedProductlist,
  });

  final String message;
  final String status;
  final List<Detail> details;
  final List<ProductReview> productReview;
  final List<RelatedProductlist> relatedProductlist;

  factory ProdDetailModel.fromJson(Map<String, dynamic> json) =>
      ProdDetailModel(
        message: json["message"],
        status: json["status"],
        details:
            List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
        productReview: List<ProductReview>.from(
            json["ProductReview"].map((x) => ProductReview.fromJson(x))),
        relatedProductlist: List<RelatedProductlist>.from(
            json["RelatedProductlist"]
                .map((x) => RelatedProductlist.fromJson(x))),
      );
}

class Detail {
  Detail({
    required this.yjProductId,
    required this.productName,
    required this.productImageUrl,
    required this.productImage,
    required this.mobile1ProductImage,
    required this.price,
    required this.productUrl,
    required this.sellerName,
    required this.sellerNameMobile,
    required this.inStockOrOutOfStock,
    required this.clientId,
    required this.forSaleBy,
    required this.brand,
    required this.description,
    required this.freeShipping,
    required this.clientLogoUrl,
    required this.allowOnlineOrder,
    required this.displayPriceFlag,
    required this.productCategoryId,
    required this.productCategorySub1Id,
    required this.productCategorySub2Id,
    required this.productTypeId,
    required this.inStock,
    required this.shippingInfo,
    required this.productColorStyleType,
    required this.size,
    required this.isMadeToOrder,
    required this.madeToOrderInformation,
    required this.youTubeVideoId,
  });

  final int? yjProductId;
  final String? productName;
  final String? productImageUrl;
  final String? productImage;
  final String? mobile1ProductImage;
  final String? price;
  final String? productUrl;
  final String? sellerName;
  final String? sellerNameMobile;
  final String? inStockOrOutOfStock;
  final int clientId;
  final String? forSaleBy;
  final String? brand;
  final String? description;
  final int freeShipping;
  final String? clientLogoUrl;
  final String? allowOnlineOrder;
  final String? displayPriceFlag;
  final int productCategoryId;
  final int productCategorySub1Id;
  final int productCategorySub2Id;
  final int productTypeId;
  final int inStock;
  final String? shippingInfo;
  final String? productColorStyleType;
  final String? size;
  final int isMadeToOrder;
  final String? madeToOrderInformation;
  final String? youTubeVideoId;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        yjProductId: json["YJProduct_ID"] ?? 0,
        productName: json["Product_Name"] ?? '',
        productImageUrl: json["Product_Image_URL"] ?? '',
        productImage: json["Product_Image"] ?? '',
        mobile1ProductImage: json["Mobile1_Product_Image"] ?? '',
        price: json["Price"] ?? '',
        productUrl: json["Product_url"] ?? '',
        sellerName: json["Seller_Name"] ?? '',
        sellerNameMobile: json["Seller_Name_Mobile"] ?? '',
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"] ?? '',
        clientId: json["Client_Id"] ?? 0,
        forSaleBy: json["for_sale_by"] ?? '',
        brand: json["brand"] ?? '',
        description: json["description"] ?? '',
        freeShipping: json["Free_Shipping"] ?? 0,
        clientLogoUrl: json["client_logo_url"] ?? '',
        allowOnlineOrder: json["allow_online_order"] ?? '',
        displayPriceFlag: json["Display_Price_Flag"] ?? '',
        productCategoryId: json["product_category_id"] ?? 0,
        productCategorySub1Id: json["product_category_sub1_id"] ?? 0,
        productCategorySub2Id: json["product_category_sub2_id"] ?? 0,
        productTypeId: json["Product_Type_Id"] ?? 0,
        inStock: json["in_stock"] ?? 0,
        shippingInfo: json["Shipping_Info"] ?? '',
        productColorStyleType: json["product_Color_Style_Type"] ?? '',
        size: json["Size"] ?? '',
        isMadeToOrder: json["Is_Made_To_Order"] ,
        madeToOrderInformation: json["Made_To_Order_Information"] ?? '',
        youTubeVideoId:
            json["YouTube_Video_Id"] == null ? '' : json["YouTube_Video_Id"],
      );
}

class ProductReview {
  ProductReview({
    required this.averageRating,
    required this.ratingCount,
  });

  final int averageRating;
  final int ratingCount;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
        averageRating: json["AverageRating"],
        ratingCount: json["RatingCount"],
      );
}

class RelatedProductlist {
  RelatedProductlist({
    required this.productTypeId,
    required this.yjProductId,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.productUrl,
    required this.brandName,
  });

  final String productTypeId;
  final int yjProductId;
  final String productName;
  final String productImageUrl;
  final String price;
  final String? productUrl;
  final String brandName;

  factory RelatedProductlist.fromJson(Map<String, dynamic> json) =>
      RelatedProductlist(
        productTypeId: json["ProductTypeId"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productImageUrl: json["Product_Image_URL"],
        price: json["Price"],
        productUrl: json["Product_url"],
        brandName: json["Brand_Name"],
      );
}
