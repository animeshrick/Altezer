class GetShippingCountryandstatelist {
    GetShippingCountryandstatelist({
        required this.message,
        required this.status,
        required this.shippingcountryList,
        required this.shippingstateList,
    });

    final String message;
    final String status;
    final List<ShippingCountryList> shippingcountryList;
    final List<ShippingStateList> shippingstateList;

    factory GetShippingCountryandstatelist.fromJson(Map<String, dynamic> json) => GetShippingCountryandstatelist(
        message: json["message"],
        status: json["status"],
        shippingcountryList: List<ShippingCountryList>.from(json["CountryList"].map((x) => ShippingCountryList.fromJson(x))),
        shippingstateList: List<ShippingStateList>.from(json["StateList"].map((x) => ShippingStateList.fromJson(x))),
    );
}

class ShippingCountryList {
    ShippingCountryList({
        required this.countryId,
        required this.shippingCountry,
    });

    final int countryId;
    final String shippingCountry;

    factory ShippingCountryList.fromJson(Map<String, dynamic> json) => ShippingCountryList(
        countryId: json["country_Id"],
        shippingCountry: json["Long_Name"],
    );
}

class ShippingStateList {
    ShippingStateList({
        required this.parishOrStateId,
        required this.shippingState,
    });

    final int parishOrStateId;
    final String shippingState;

    factory ShippingStateList.fromJson(Map<String, dynamic> json) => ShippingStateList(
        parishOrStateId: json["Parish_or_State_id"],
        shippingState: json["Long_name"],
    );
}
