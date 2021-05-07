class GetSort {
  final String message, status;
  final List<GetSortByData> sortList;

  GetSort(
      {required this.message, required this.status, required this.sortList});

  factory GetSort.fromJson(Map<String, dynamic> myjson) {
    return GetSort(
        message: myjson['message'],
        status: myjson['status'],
        sortList: (myjson['SortByList'] as List)
            .map((e) => GetSortByData.fromJson(e))
            .toList());
  }
}

class GetSortByData {
  final String sortName;
  final int sortId;

  GetSortByData({required this.sortId, required this.sortName});

  factory GetSortByData.fromJson(Map<String, dynamic> myjson) {
    return GetSortByData(
        sortId: myjson['code_id'], sortName: myjson['Long_name']);
  }
}
