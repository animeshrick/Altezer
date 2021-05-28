class GetBankCountryList {
    GetBankCountryList({
        required this.message,
        required this.status,
        required this.stateList,
    });

    final String message;
    final String status;
    final List<StateList> stateList;

    factory GetBankCountryList.fromJson(Map<String, dynamic> json) => GetBankCountryList(
        message: json["message"],
        status: json["status"],
        stateList: List<StateList>.from(json["StateList"].map((x) => StateList.fromJson(x))),
    );
}

class StateList {
    StateList({
        required this.parishOrStateId,
        required this.bankState,
    });

    final int parishOrStateId;
    final String bankState;

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        parishOrStateId: json["Parish_or_State_id"],
        bankState: json["Long_name"],
    );
}
