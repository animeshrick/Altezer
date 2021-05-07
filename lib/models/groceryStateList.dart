class GetGroceryState {
  final String message, status;
  final List<GetGroceryStateList> groceryStateList;

  GetGroceryState(
      {required this.message,
      required this.status,
      required this.groceryStateList});

  factory GetGroceryState.fromJson(Map<String, dynamic> myjson) {
    return GetGroceryState(
        message: myjson['message'],
        status: myjson['status'],
        groceryStateList: (myjson['StateList'] as List)
            .map((e) => GetGroceryStateList.fromJson(e))
            .toList());
  }
}

class GetGroceryStateList {
  final String groceryStateName;
  final int groceryStateId;

  GetGroceryStateList(
      {required this.groceryStateId, required this.groceryStateName});

  factory GetGroceryStateList.fromJson(Map<String, dynamic> myjson) {
    return GetGroceryStateList(
        groceryStateId: myjson['Parish_or_State_id'],
        groceryStateName: myjson['Long_name']);
  }
}
