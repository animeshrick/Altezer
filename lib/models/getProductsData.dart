class GetProducts {
  final String message, status;
  final List<ProductListData> prdListData;

  GetProducts(
      {required this.message, required this.status, required this.prdListData});

  factory GetProducts.fromJson(Map<String, dynamic> myjson) {
    return GetProducts(
        message: myjson['message'],
        status: myjson['status'],
        prdListData: myjson['productlist'] == null
            ? []
            : (myjson['productlist'] as List)
                .map((e) => ProductListData.fromJson(e))
                .toList());
  }
}

class ProductListData {
  final String prdId,
      prdName,
      prdFullName,
      prdImg,
      price,
      prdUrl,
      sellerName,
      sellerNameMobile,
      inoutStock,
      allowOnlineOrder,
      displayPriceFlag,
      perks,
      size;
  final int yjprdId,
      prdCatId,
      prdCatSubId1,
      prdCatSubId2,
      inStock,
      isMadetoOrder,
      clientId;

  ProductListData(
      {required this.prdId,
      required this.prdName,
      required this.prdFullName,
      required this.prdImg,
      required this.price,
      required this.prdUrl,
      required this.sellerName,
      required this.sellerNameMobile,
      required this.inoutStock,
      required this.allowOnlineOrder,
      required this.displayPriceFlag,
      required this.perks,
      required this.size,
      required this.yjprdId,
      required this.prdCatId,
      required this.prdCatSubId1,
      required this.prdCatSubId2,
      required this.inStock,
      required this.isMadetoOrder,
      required this.clientId});

  factory ProductListData.fromJson(Map<String, dynamic> myjson) {
    return ProductListData(
        prdId: myjson['ProductTypeId'],
        prdName: myjson['Product_Name'],
        prdFullName: myjson['Product_FullName'],
        prdImg: myjson['Product_Image_URL'],
        price: myjson['Price'],
        prdUrl: myjson['Product_url'],
        sellerName: myjson['Seller_Name'],
        sellerNameMobile: myjson['Seller_Name_Mobile'],
        inoutStock: myjson['InStock_Or_OutOfStock'],
        allowOnlineOrder: myjson['allow_online_order'],
        displayPriceFlag: myjson['Display_Price_Flag'],
        perks: myjson['Perks'],
        size: myjson['Size'],
        yjprdId: myjson['YJProduct_ID'],
        prdCatId: myjson['Product_Category_ID'],
        prdCatSubId1: myjson['Product_Category_Sub1_ID'],
        prdCatSubId2: myjson['Product_Category_Sub2_ID'],
        inStock: myjson['in_stock'],
        isMadetoOrder: myjson['is_Made_To_Order'],
        clientId: myjson['client_id']);
  }
}
