class PrdDetailModel2 {
    PrdDetailModel2({
        required this.message,
        required this.status,
        required this.details,
        required this.productReview,
        required this.relatedProductlist,
    });

    final String message;
    final String status;
    final List<Detail> details;
    final List<ProductReview> productReview;
    final List<RelatedProductlist> relatedProductlist;

    factory PrdDetailModel2.fromJson(Map<String, dynamic> json) => PrdDetailModel2(
        message: json["message"],
        status: json["status"],
        details: List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
        productReview: List<ProductReview>.from(json["ProductReview"].map((x) => ProductReview.fromJson(x))),
        relatedProductlist: List<RelatedProductlist>.from(json["RelatedProductlist"].map((x) => RelatedProductlist.fromJson(x))),
    );
}

class Detail {
    Detail({
        required this.autoPartId,
        required this.autoPartName,
        required this.autoPartCategoryId,
        required this.autoPartCategorySub1Id,
        required this.brandId,
        required this.companyId,
        required this.price,
        required this.autoPartImageUrl,
        required this.deleteFlag,
        required this.timeStamp,
        required this.autoPartInfo,
        required this.sellerTypeCode,
        required this.storeId,
        required this.modelNumber,
        required this.individualSellerId,
        required this.inStock,
        required this.autoPartUrl,
        required this.isSpecial,
        required this.autoPartDescription,
        required this.sellerAutoPartId,
        required this.conditionTypeCode,
        required this.partNumber,
        required this.clientId,
        required this.autoPartsListId,
        required this.partsModels,
        required this.yearModels,
        required this.qty,
        required this.searchKeyWord,
        required this.allowOnlineOrder,
        required this.isActive,
        required this.isFreeShipping,
        required this.poundWeight,
        required this.productCategoryId,
        required this.isSalesTaxable,
        required this.size,
        required this.clientId1,
        required this.name,
        required this.address,
        required this.address2,
        required this.city,
        required this.parishId,
        required this.postalCode,
        required this.contactPhone2,
        required this.contactPerson,
        required this.contactPersonEmail,
        required this.website,
        required this.timeStamp1,
        required this.contactPhone1,
        required this.deleteFlag1,
        required this.companyId1,
        required this.clientLogoUrl,
        required this.clientPolicy,
        required this.clientCoverPhoto,
        required this.clientWebsite,
        required this.clientMainAdUrl,
        required this.clientCountryId,
        required this.userGuid,
        required this.smptMailServer,
        required this.systemEmail,
        required this.smsAccountSid,
        required this.smsAuthToken,
        required this.smsPhoneNumber,
        required this.parishOrStateId,
        required this.longName,
        required this.shortName,
        required this.countryId,
        required this.deleteFlag2,
        required this.timeStamp2,
        required this.brandId1,
        required this.name1,
        required this.deleteFlag3,
        required this.timeStamp3,
        required this.productBrandCategoryId,
        required this.noOfItems,
        required this.manufacturer,
        required this.address1,
        required this.website1,
        required this.countryId1,
        required this.longName1,
        required this.shortName1,
        required this.timeStamp4,
        required this.deleteFlag4,
        required this.regionId,
        required this.shippingCountryRank,
        required this.yjProductId,
        required this.productName,
        required this.productImage,
        required this.mobile1ProductImage,
        required this.price1,
        required this.productUrl,
        required this.productImageUrl,
        required this.sellerName,
        required this.sellerNameMobile,
        required this.inStockOrOutOfStock,
        required this.clientId2,
        required this.forSaleBy,
        required this.sellerName1,
        required this.brand,
        required this.description,
        required this.price2,
        required this.clientLogoUrl1,
        required this.allowOnlineOrder1,
        required this.displayPriceFlag,
        required this.productCategoryId1,
        required this.productCategorySub1Id,
        required this.productCategorySub2Id,
        required this.productTypeId,
        required this.inStock1,
        required this.shippingInfo,
        required this.freeShipping,
        required this.productColorStyleType,
        required this.size1,
        required this.isMadeToOrder,
        required this.madeToOrderInformation,
        required this.youTubeVideoId,
    });

    final int autoPartId;
    final String autoPartName;
    final int autoPartCategoryId;
    final dynamic autoPartCategorySub1Id;
    final int brandId;
    final int companyId;
    final int price;
    final String autoPartImageUrl;
    final int deleteFlag;
    final DateTime timeStamp;
    final String autoPartInfo;
    final dynamic sellerTypeCode;
    final dynamic storeId;
    final String modelNumber;
    final dynamic individualSellerId;
    final bool inStock;
    final String autoPartUrl;
    final bool isSpecial;
    final String autoPartDescription;
    final String sellerAutoPartId;
    final int conditionTypeCode;
    final String partNumber;
    final int clientId;
    final dynamic autoPartsListId;
    final dynamic partsModels;
    final dynamic yearModels;
    final int qty;
    final String searchKeyWord;
    final bool allowOnlineOrder;
    final bool isActive;
    final bool isFreeShipping;
    final int poundWeight;
    final int productCategoryId;
    final dynamic isSalesTaxable;
    final dynamic size;
    final int clientId1;
    final String name;
    final String address;
    final String address2;
    final String city;
    final String parishId;
    final String postalCode;
    final String contactPhone2;
    final String contactPerson;
    final String contactPersonEmail;
    final String website;
    final String timeStamp1;
    final String contactPhone1;
    final bool deleteFlag1;
    final int companyId1;
    final dynamic clientLogoUrl;
    final dynamic clientPolicy;
    final dynamic clientCoverPhoto;
    final dynamic clientWebsite;
    final dynamic clientMainAdUrl;
    final int clientCountryId;
    final String userGuid;
    final dynamic smptMailServer;
    final dynamic systemEmail;
    final dynamic smsAccountSid;
    final dynamic smsAuthToken;
    final dynamic smsPhoneNumber;
    final int parishOrStateId;
    final String longName;
    final String shortName;
    final int countryId;
    final bool deleteFlag2;
    final DateTime timeStamp2;
    final int brandId1;
    final String name1;
    final int deleteFlag3;
    final DateTime timeStamp3;
    final dynamic productBrandCategoryId;
    final dynamic noOfItems;
    final dynamic manufacturer;
    final dynamic address1;
    final dynamic website1;
    final int countryId1;
    final String longName1;
    final String shortName1;
    final DateTime timeStamp4;
    final bool deleteFlag4;
    final int regionId;
    final int shippingCountryRank;
    final int yjProductId;
    final String productName;
    final String productImage;
    final String mobile1ProductImage;
    final String price1;
    final String productUrl;
    final String productImageUrl;
    final String sellerName;
    final String sellerNameMobile;
    final String inStockOrOutOfStock;
    final int clientId2;
    final String forSaleBy;
    final String sellerName1;
    final String brand;
    final String description;
    final int price2;
    final dynamic clientLogoUrl1;
    final String allowOnlineOrder1;
    final String displayPriceFlag;
    final int productCategoryId1;
    final int productCategorySub1Id;
    final int productCategorySub2Id;
    final int productTypeId;
    final int inStock1;
    final String shippingInfo;
    final int freeShipping;
    final String productColorStyleType;
    final String size1;
    final int isMadeToOrder;
    final String madeToOrderInformation;
    final String youTubeVideoId;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        autoPartId: json["Auto_Part_ID"],
        autoPartName: json["Auto_Part_Name"],
        autoPartCategoryId: json["Auto_Part_Category_ID"],
        autoPartCategorySub1Id: json["Auto_Part_Category_Sub1_ID"],
        brandId: json["Brand_ID"],
        companyId: json["Company_ID"],
        price: json["Price"],
        autoPartImageUrl: json["Auto_Part_Image_URL"],
        deleteFlag: json["Delete_Flag"],
        timeStamp: DateTime.parse(json["Time_Stamp"]),
        autoPartInfo: json["Auto_Part_Info"],
        sellerTypeCode: json["Seller_Type_Code"],
        storeId: json["Store_Id"],
        modelNumber: json["Model_Number"],
        individualSellerId: json["Individual_Seller_Id"],
        inStock: json["In_Stock"],
        autoPartUrl: json["Auto_Part_url"],
        isSpecial: json["Is_Special"],
        autoPartDescription: json["Auto_Part_Description"],
        sellerAutoPartId: json["Seller_Auto_Part_Id"],
        conditionTypeCode: json["Condition_Type_Code"],
        partNumber: json["Part_Number"],
        clientId: json["Client_Id"],
        autoPartsListId: json["Auto_Parts_List_Id"],
        partsModels: json["Parts_Models"],
        yearModels: json["Year_Models"],
        qty: json["Qty"],
        searchKeyWord: json["Search_Key_Word"],
        allowOnlineOrder: json["allow_online_order"],
        isActive: json["Is_Active"],
        isFreeShipping: json["Is_Free_Shipping"],
        poundWeight: json["Pound_Weight"],
        productCategoryId: json["Product_Category_Id"],
        isSalesTaxable: json["Is_Sales_Taxable"],
        size: json["size"],
        clientId1: json["Client_Id1"],
        name: json["Name"],
        address: json["Address"],
        address2: json["Address2"],
        city: json["City"],
        parishId: json["Parish_Id"],
        postalCode: json["Postal_Code"],
        contactPhone2: json["Contact_Phone2"],
        contactPerson: json["Contact_Person"],
        contactPersonEmail: json["Contact_Person_Email"],
        website: json["Website"],
        timeStamp1: json["Time_Stamp1"],
        contactPhone1: json["Contact_Phone1"],
        deleteFlag1: json["Delete_Flag1"],
        companyId1: json["Company_Id1"],
        clientLogoUrl: json["Client_Logo_URL"],
        clientPolicy: json["Client_Policy"],
        clientCoverPhoto: json["Client_Cover_Photo"],
        clientWebsite: json["Client_Website"],
        clientMainAdUrl: json["Client_Main_Ad_URL"],
        clientCountryId: json["Client_Country_Id"],
        userGuid: json["User_GUID"],
        smptMailServer: json["SMPT_Mail_Server"],
        systemEmail: json["System_Email"],
        smsAccountSid: json["SMS_AccountSid"],
        smsAuthToken: json["SMS_AuthToken"],
        smsPhoneNumber: json["SMS_Phone_Number"],
        parishOrStateId: json["Parish_Or_State_Id"],
        longName: json["Long_Name"],
        shortName: json["Short_Name"],
        countryId: json["Country_Id"],
        deleteFlag2: json["Delete_Flag2"],
        timeStamp2: DateTime.parse(json["Time_Stamp2"]),
        brandId1: json["Brand_ID1"],
        name1: json["Name1"],
        deleteFlag3: json["Delete_Flag3"],
        timeStamp3: DateTime.parse(json["Time_Stamp3"]),
        productBrandCategoryId: json["Product_Brand_category_ID"],
        noOfItems: json["No_of_items"],
        manufacturer: json["Manufacturer"],
        address1: json["Address1"],
        website1: json["Website1"],
        countryId1: json["Country_Id1"],
        longName1: json["Long_Name1"],
        shortName1: json["Short_Name1"],
        timeStamp4: DateTime.parse(json["Time_Stamp4"]),
        deleteFlag4: json["Delete_Flag4"],
        regionId: json["Region_Id"],
        shippingCountryRank: json["Shipping_Country_Rank"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productImage: json["Product_Image"],
        mobile1ProductImage: json["Mobile1_Product_Image"],
        price1: json["Price1"],
        productUrl: json["Product_url"],
        productImageUrl: json["Product_Image_URL"],
        sellerName: json["Seller_Name"],
        sellerNameMobile: json["Seller_Name_Mobile"],
        inStockOrOutOfStock: json["InStock_Or_OutOfStock"],
        clientId2: json["Client_Id2"],
        forSaleBy: json["for_sale_by"],
        sellerName1: json["Seller_Name1"],
        brand: json["brand"],
        description: json["description"],
        price2: json["price2"],
        clientLogoUrl1: json["client_logo_url1"],
        allowOnlineOrder1: json["allow_online_order1"],
        displayPriceFlag: json["Display_Price_Flag"],
        productCategoryId1: json["product_category_id1"],
        productCategorySub1Id: json["product_category_sub1_id"],
        productCategorySub2Id: json["product_category_sub2_id"],
        productTypeId: json["Product_Type_Id"],
        inStock1: json["in_stock1"],
        shippingInfo: json["Shipping_Info"],
        freeShipping: json["Free_Shipping"],
        productColorStyleType: json["product_Color_Style_Type"],
        size1: json["Size1"],
        isMadeToOrder: json["Is_Made_To_Order"],
        madeToOrderInformation: json["Made_To_Order_Information"],
        youTubeVideoId: json["YouTube_Video_Id"],
    );

 }

class ProductReview {
    ProductReview({
        required this.averageRating,
        required this.ratingCount,
    });

    final int averageRating;
    final int ratingCount;

    factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
        averageRating: json["AverageRating"],
        ratingCount: json["RatingCount"],
    );
}

class RelatedProductlist {
    RelatedProductlist({
        required this.productTypeId,
        required this.yjProductId,
        required this.productName,
        required this.productImage,
        required this.productImageUrl,
        required this.price,
        required this.productUrl,
        required this.brandName,
    });

    final String productTypeId;
    final int yjProductId;
    final String productName;
    final String productImage;
    final String productImageUrl;
    final String price;
    final String productUrl;
    final String brandName;

    factory RelatedProductlist.fromJson(Map<String, dynamic> json) => RelatedProductlist(
        productTypeId: json["ProductTypeId"],
        yjProductId: json["YJProduct_ID"],
        productName: json["Product_Name"],
        productImage: json["Product_Image"],
        productImageUrl: json["Product_Image_URL"],
        price: json["Price"],
        productUrl: json["Product_url"],
        brandName: json["Brand_Name"],
    );
}
