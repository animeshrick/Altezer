class GetLatestDeals {
  final String message, status;
  final List<LatestDealsList> latestDealsList;

  GetLatestDeals(
      {required this.message,
      required this.status,
      required this.latestDealsList});

  factory GetLatestDeals.fromJson(Map<String, dynamic> myjson) {
    return GetLatestDeals(
      message: myjson['message'],
      status: myjson['status'],
      latestDealsList: (myjson['latestDeallist'] as List)
          .map((e) => LatestDealsList.fromJSon(e))
          .toList(),
    );
  }
}

class LatestDealsList {
  final String latestprdName,
      latestprdImgUrl,
      latestPrice,
      latestUsprice,
      latestPrdUrl,
      latestSellerName,
      latestParks;
  final int latestprdTypeId, latestyjPrdId, latestCourrencyCode;

  LatestDealsList({
    required this.latestprdName,
    required this.latestprdImgUrl,
    required this.latestPrice,
    required this.latestUsprice,
    required this.latestPrdUrl,
    required this.latestSellerName,
    required this.latestParks,
    required this.latestprdTypeId,
    required this.latestyjPrdId,
    required this.latestCourrencyCode,
  });

  factory LatestDealsList.fromJSon(Map<String, dynamic> myjson) {
    return LatestDealsList(
        latestprdName: myjson['Product_Name'],
        latestprdImgUrl: myjson['Product_Image_URL'],
        latestPrice: myjson['Price'],
        latestUsprice: myjson['US_Price'],
        latestPrdUrl: myjson['Product_url'],
        latestSellerName: myjson['Seller_Name'],
        latestParks: myjson['Perks'],
        latestprdTypeId: myjson['ProductTypeId'],
        latestyjPrdId: myjson['YJProduct_ID'],
        latestCourrencyCode: myjson['currency_code']);
  }
}
