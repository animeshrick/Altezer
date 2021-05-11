class GetGroceryStore {
  final String message, status;
  final List<GetGroceryStoreList> groceryStoreList;

  GetGroceryStore(
      {required this.message,
      required this.status,
      required this.groceryStoreList});

  factory GetGroceryStore.fromJson(Map<String, dynamic> myjson) {
    return GetGroceryStore(
        message: myjson['message'],
        status: myjson['status'],
        groceryStoreList: (myjson['StoreList'] as List)
            .map((e) => GetGroceryStoreList.fromJson(e))
            .toList());
  }
}

class GetGroceryStoreList {
  final String? storeName, storeLogoUrl, storeWebsite, website, storeLocation;
  final int cId;

  GetGroceryStoreList(
      {required this.storeName,
      required this.storeLogoUrl,
      required this.storeWebsite,
      required this.website,
      required this.storeLocation,
      required this.cId});

  factory GetGroceryStoreList.fromJson(Map<String, dynamic> myjson) {
    return GetGroceryStoreList(
        cId: myjson['Client_Id'] as int,
        storeName: myjson['Client_Name'],
        storeLogoUrl: myjson['Client_Logo_URL'],
        storeLocation: myjson['Location'],
        storeWebsite: myjson['Client_Website'],
        website: myjson['Website']);
  }
}
