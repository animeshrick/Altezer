class GetDealsList {
  final String message, status;
  final List<DealsListData> dealList;

  GetDealsList(
      {required this.message, required this.status, required this.dealList});

  factory GetDealsList.fromJson(Map<String, dynamic> myjson) {
    return GetDealsList(
        message: myjson['message'],
        status: myjson['status'],
        dealList: (myjson['StoreList'] as List)
            .map((e) => DealsListData.fromJson(e))
            .toList());
  }
}

class DealsListData {
  String productTypeId,
      productName,
      productImageURL,
      price,
      productUrl,
      sellerName,
      perks,
      timeStamp;
  int isMadeToOrder, yJProductID;

  DealsListData(
      {required this.productTypeId,
      required this.yJProductID,
      required this.productName,
      required this.productImageURL,
      required this.price,
      required this.productUrl,
      required this.sellerName,
      required this.perks,
      required this.timeStamp,
      required this.isMadeToOrder});

  factory DealsListData.fromJson(Map<String, dynamic> myjson) {
    return DealsListData(
        productTypeId: myjson['ProductTypeId'],
        yJProductID: myjson['YJProduct_ID'],
        productName: myjson['Product_Name'],
        productImageURL: myjson['Product_Image_URL'],
        price: myjson['Price'],
        productUrl: myjson['Product_url'],
        sellerName: myjson['Seller_Name'],
        perks: myjson['Perks'],
        timeStamp: myjson['Time_Stamp'],
        isMadeToOrder: myjson['is_Made_To_Order']);
  }
}
