class RegistryItemListByRegIdModel {
    RegistryItemListByRegIdModel({
        required this.message,
        required this.status,
        required this.listOfRegistryItems,
    });

    final String message;
    final String status;
    final List<ListOfRegistryItem> listOfRegistryItems;

    factory RegistryItemListByRegIdModel.fromJson(Map<String, dynamic> json) => RegistryItemListByRegIdModel(
        message: json["message"],
        status: json["status"],
        listOfRegistryItems: json["ListOfRegistryItems"] == '' ? [] :   List<ListOfRegistryItem>.from(json["ListOfRegistryItems"].map((x) => ListOfRegistryItem.fromJson(x))),
    );
    //json["ListOfRegistryItems"] == '' ? null : 
}

class ListOfRegistryItem {
    ListOfRegistryItem({
        required this.registryItemId,
        required this.registryId,
        required this.productName,
        required this.productId,
        required this.productImageUrl,
        required this.productTypeId,
        required this.yjProductId,
        required this.productName1,
        required this.productFullName,
        required this.productImageUrl1,
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
        required this.qty,
    });

    final int registryItemId;
    final int registryId;
    final String productName;
    final int productId;
    final String productImageUrl;
    final String productTypeId;
    final int yjProductId;
    final String productName1;
    final String productFullName;
    final String productImageUrl1;
    final String price;
    final String productUrl;
    final String sellerName;
    final String sellerNameMobile;
    final int productCategoryId;
    final int productCategorySub1Id;
    final int productCategorySub2Id;
    final String inStockOrOutOfStock;
    final int inStock;
    final int clientId;
    final String allowOnlineOrder;
    final String displayPriceFlag;
    final String perks;
    final int isMadeToOrder;
    final int qty;

    factory ListOfRegistryItem.fromJson(Map<String, dynamic> json) => ListOfRegistryItem(
        registryItemId: json["Registry_Item_ID"],
        registryId: json["Registry_ID"],
        productName: json["Product_Name"],
        productId: json["Product_ID"],
        productImageUrl: json["Product_Image_URL"],
        productTypeId: json["ProductTypeId"],
        yjProductId: json["YJProduct_ID"],
        productName1: json["Product_Name1"],
        productFullName: json["Product_FullName"],
        productImageUrl1: json["Product_Image_URL1"],
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
        qty: json["Qty"],
    );
}
