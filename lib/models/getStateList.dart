class GetStateList {
  final String message;
  final String status;
  final List<StateList> stateList;

  GetStateList(
      {required this.message, required this.status, required this.stateList});
  factory GetStateList.fromJson(Map<String, dynamic> myjson) {
    return GetStateList(
      message: myjson['message'],
      status: myjson['status'],
      stateList: (myjson['StateList'] as List)
          .map((e) => StateList.fromJson(e))
          .toList(),
    );
  }
}

class StateList {
  int stateId;
  String stateName;

  StateList({required this.stateId, required this.stateName});
  factory StateList.fromJson(Map<String, dynamic> myjson) {
    return StateList(
      stateId: myjson['Parish_or_State_id'],
      stateName: myjson['Long_name'],
    );
  }
}
