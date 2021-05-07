class GetStoreList {
  String message, status;
  List<StoreList> storedataList;

  GetStoreList(
      {required this.message,
      required this.status,
      required this.storedataList});

  factory GetStoreList.fromJson(Map<String, dynamic> myjson) {
    return GetStoreList(
        message: myjson['message'],
        status: myjson['status'],
        storedataList: (myjson['StoreList'] as List)
            .map((e) => StoreList.fromJSon(e))
            .toList());
  }
}

class StoreList {
  int clientId;
  String clientName;
  String clientLogoURL;
  Null clientWebsite;
  String website;
  String location;
  int isAdultStore;

  StoreList(
      {required this.clientId,
      required this.clientName,
      required this.clientLogoURL,
      required this.clientWebsite,
      required this.website,
      required this.location,
      required this.isAdultStore});

  factory StoreList.fromJSon(Map<String, dynamic> myjson) {
    return StoreList(
        clientId: myjson['Client_Id'],
        clientName: myjson['Client_Name'],
        clientLogoURL: myjson['Client_Logo_URL'],
        clientWebsite: myjson['Client_Website'],
        website: myjson['Website'],
        location: myjson['Location'],
        isAdultStore: myjson['is_Adult_Store']);
  }
}
