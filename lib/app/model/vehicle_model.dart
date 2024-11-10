class VehicleModel {
  // final int id;
  // final String vin;
  // final String displayColor;
  // final int year;
  final String make;
  final String model;
  // final String price;
  // final String mileage;
  // final String city;
  // final double lat;
  // final double lon;
  final String primaryPhotoUrl;
  // final String condition;
  // final int providerId;
  // final String createdAt;
  // final String updatedAt;
  // final int modelId;
  // final String dealerName;
  // final bool active;
  // final String state;
  // final String trim;
  // final String clickoffUrl;
  // final bool acceptsLeads;
  // final String bodyType;
  // final String bodyStyle;
  // final String? regionName;
  // final String experience;
  // final bool requiresAddressWithLead;
  // final TrackingParams trackingParams;
  // final int providerGroupId;
  // final int mileageUnformatted;
  // final String mileageHumanized;
  // final String priceMobile;
  // final int priceUnformatted;
  // final bool recentPriceDrop;
  // final String vdpUrl;
  // final bool showNewMileage;
  // final bool eligibleForFinancing;
  // final String financingExperience;
  // final List<String> photoUrls;
  // final bool isHot;
  // final String hrefTarget;
  // final int distanceFromOrigin;
  // final String? humanizedSearchLocation;
  // final bool? hideDistance;
  // final String? noPriceText;
  // final String? target;
  // final int monthlyPayment;
  // final bool clickOff;
  // final bool emailOptDefault;
  // final bool showThankyouPage;
  // final bool showRsrp;
  // final bool allowOneClickSubmit;
  // final bool paidAllowOneClickSubmit;
  // final bool newPriceAsMsrp;
  // final bool preCheckThankyou;
  // final bool preCheckThankyouMobile;
  // final bool openInNewWindow;
  // final bool alwaysAskForZip;
  // final bool requireEmailOptIn;
  // final String providerName;
  // final bool availableNationwide;
  // final bool regional;
  // final String thumbnailUrl;
  // final String thumbnailUrlLarge;
  // final bool quickPicksEligible;
  // final String dealerGroupUuid;
  // final int cplValue;
  // final String partnerType;

  VehicleModel({
    // required this.id,
    // required this.vin,
    // required this.displayColor,
    // required this.year,
    required this.make,
    required this.model,
    // required this.price,
    // required this.mileage,
    // required this.city,
    // required this.lat,
    // required this.lon,
    required this.primaryPhotoUrl,
    // required this.condition,
    // required this.providerId,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.modelId,
    // required this.dealerName,
    // required this.active,
    // required this.state,
    // required this.trim,
    // required this.clickoffUrl,
    // required this.acceptsLeads,
    // required this.bodyType,
    // required this.bodyStyle,
    // this.regionName,
    // required this.experience,
    // required this.requiresAddressWithLead,
    // required this.trackingParams,
    // required this.providerGroupId,
    // required this.mileageUnformatted,
    // required this.mileageHumanized,
    // required this.priceMobile,
    // required this.priceUnformatted,
    // required this.recentPriceDrop,
    // required this.vdpUrl,
    // required this.showNewMileage,
    // required this.eligibleForFinancing,
    // required this.financingExperience,
    // required this.photoUrls,
    // required this.isHot,
    // required this.hrefTarget,
    // required this.distanceFromOrigin,
    // this.humanizedSearchLocation,
    // this.hideDistance,
    // this.noPriceText,
    // this.target,
    // required this.monthlyPayment,
    // required this.clickOff,
    // required this.emailOptDefault,
    // required this.showThankyouPage,
    // required this.showRsrp,
    // required this.allowOneClickSubmit,
    // required this.paidAllowOneClickSubmit,
    // required this.newPriceAsMsrp,
    // required this.preCheckThankyou,
    // required this.preCheckThankyouMobile,
    // required this.openInNewWindow,
    // required this.alwaysAskForZip,
    // required this.requireEmailOptIn,
    // required this.providerName,
    // required this.availableNationwide,
    // required this.regional,
    // required this.thumbnailUrl,
    // required this.thumbnailUrlLarge,
    // required this.quickPicksEligible,
    // required this.dealerGroupUuid,
    // required this.cplValue,
    // required this.partnerType,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      // id: json['id'],
      // vin: json['vin'],
      // displayColor: json['displayColor'],
      // year: json['year'],
      make: json['make'],
      model: json['model'],
      // price: json['price'],
      // mileage: json['mileage'],
      // city: json['city'],
      // lat: json['lat'],
      // lon: json['lon'],
      primaryPhotoUrl: json['primaryPhotoUrl'],
      // condition: json['condition'],
      // providerId: json['providerId'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
      // modelId: json['modelId'],
      // dealerName: json['dealerName'],
      // active: json['active'],
      // state: json['state'],
      // trim: json['trim'],
      // clickoffUrl: json['clickoffUrl'],
      // acceptsLeads: json['acceptsLeads'],
      // bodyType: json['bodyType'],
      // bodyStyle: json['bodyStyle'],
      // regionName: json['regionName'],
      // experience: json['experience'],
      // requiresAddressWithLead: json['requiresAddressWithLead'],
      // trackingParams: TrackingParams.fromJson(json['trackingParams']),
      // providerGroupId: json['providerGroupId'],
      // mileageUnformatted: json['mileageUnformatted'],
      // mileageHumanized: json['mileageHumanized'],
      // priceMobile: json['priceMobile'],
      // priceUnformatted: json['priceUnformatted'],
      // recentPriceDrop: json['recentPriceDrop'],
      // vdpUrl: json['vdpUrl'],
      // showNewMileage: json['showNewMileage'],
      // eligibleForFinancing: json['eligibleForFinancing'],
      // financingExperience: json['financingExperience'],
      // photoUrls: List<String>.from(json['photoUrls']),
      // isHot: json['isHot'],
      // hrefTarget: json['hrefTarget'],
      // distanceFromOrigin: json['distanceFromOrigin'],
      // humanizedSearchLocation: json['humanizedSearchLocation'],
      // hideDistance: json['hideDistance'],
      // noPriceText: json['noPriceText'],
      // target: json['target'],
      // monthlyPayment: json['monthlyPayment'],
      // clickOff: json['clickOff'],
      // emailOptDefault: json['emailOptDefault'],
      // showThankyouPage: json['showThankyouPage'],
      // showRsrp: json['showRsrp'],
      // allowOneClickSubmit: json['allowOneClickSubmit'],
      // paidAllowOneClickSubmit: json['paidAllowOneClickSubmit'],
      // newPriceAsMsrp: json['newPriceAsMsrp'],
      // preCheckThankyou: json['preCheckThankyou'],
      // preCheckThankyouMobile: json['preCheckThankyouMobile'],
      // openInNewWindow: json['openInNewWindow'],
      // alwaysAskForZip: json['alwaysAskForZip'],
      // requireEmailOptIn: json['requireEmailOptIn'],
      // providerName: json['providerName'],
      // availableNationwide: json['availableNationwide'],
      // regional: json['regional'],
      // thumbnailUrl: json['thumbnailUrl'],
      // thumbnailUrlLarge: json['thumbnailUrlLarge'],
      // quickPicksEligible: json['quickPicksEligible'],
      // dealerGroupUuid: json['dealerGroupUuid'],
      // cplValue: json['cplValue'],
      // partnerType: json['partnerType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'vin': vin,
      // 'displayColor': displayColor,
      // 'year': year,
      'make': make,
      'model': model,
      // 'price': price,
      // 'mileage': mileage,
      // 'city': city,
      // 'lat': lat,
      // 'lon': lon,
      'primaryPhotoUrl': primaryPhotoUrl,
      // 'condition': condition,
      // 'providerId': providerId,
      // 'createdAt': createdAt,
      // 'updatedAt': updatedAt,
      // 'modelId': modelId,
      // 'dealerName': dealerName,
      // 'active': active,
      // 'state': state,
      // 'trim': trim,
      // 'clickoffUrl': clickoffUrl,
      // 'acceptsLeads': acceptsLeads,
      // 'bodyType': bodyType,
      // 'bodyStyle': bodyStyle,
      // 'regionName': regionName,
      // 'experience': experience,
      // 'requiresAddressWithLead': requiresAddressWithLead,
      // 'trackingParams': trackingParams.toJson(),
      // 'providerGroupId': providerGroupId,
      // 'mileageUnformatted': mileageUnformatted,
      // 'mileageHumanized': mileageHumanized,
      // 'priceMobile': priceMobile,
      // 'priceUnformatted': priceUnformatted,
      // 'recentPriceDrop': recentPriceDrop,
      // 'vdpUrl': vdpUrl,
      // 'showNewMileage': showNewMileage,
      // 'eligibleForFinancing': eligibleForFinancing,
      // 'financingExperience': financingExperience,
      // 'photoUrls': photoUrls,
      // 'isHot': isHot,
      // 'hrefTarget': hrefTarget,
      // 'distanceFromOrigin': distanceFromOrigin,
      // 'humanizedSearchLocation': humanizedSearchLocation,
      // 'hideDistance': hideDistance,
      // 'noPriceText': noPriceText,
      // 'target': target,
      // 'monthlyPayment': monthlyPayment,
      // 'clickOff': clickOff,
      // 'emailOptDefault': emailOptDefault,
      // 'showThankyouPage': showThankyouPage,
      // 'showRsrp': showRsrp,
      // 'allowOneClickSubmit': allowOneClickSubmit,
      // 'paidAllowOneClickSubmit': paidAllowOneClickSubmit,
      // 'newPriceAsMsrp': newPriceAsMsrp,
      // 'preCheckThankyou': preCheckThankyou,
      // 'preCheckThankyouMobile': preCheckThankyouMobile,
      // 'openInNewWindow': openInNewWindow,
      // 'alwaysAskForZip': alwaysAskForZip,
      // 'requireEmailOptIn': requireEmailOptIn,
      // 'providerName': providerName,
      // 'availableNationwide': availableNationwide,
      // 'regional': regional,
      // 'thumbnailUrl': thumbnailUrl,
      // 'thumbnailUrlLarge': thumbnailUrlLarge,
      // 'quickPicksEligible': quickPicksEligible,
      // 'dealerGroupUuid': dealerGroupUuid,
      // 'cplValue': cplValue,
      // 'partnerType': partnerType,
    };
  }
}

class TrackingParams {
  final String idFromProvider;
  final String remoteDealerId;
  final String dealerName;
  final String remoteSku;
  final String experience;
  final String? rooftopUniqueName;
  final String? rooftopUuid;
  final String dealerUniqueName;
  final String dealerUuid;
  final String dealerGroupUniqueName;
  final String dealerGroupUuid;

  TrackingParams({
    required this.idFromProvider,
    required this.remoteDealerId,
    required this.dealerName,
    required this.remoteSku,
    required this.experience,
    this.rooftopUniqueName,
    this.rooftopUuid,
    required this.dealerUniqueName,
    required this.dealerUuid,
    required this.dealerGroupUniqueName,
    required this.dealerGroupUuid,
  });

  factory TrackingParams.fromJson(Map<String, dynamic> json) {
    return TrackingParams(
      idFromProvider: json['idFromProvider'],
      remoteDealerId: json['remoteDealerId'],
      dealerName: json['dealerName'],
      remoteSku: json['remoteSku'],
      experience: json['experience'],
      rooftopUniqueName: json['rooftopUniqueName'],
      rooftopUuid: json['rooftopUuid'],
      dealerUniqueName: json['dealerUniqueName'],
      dealerUuid: json['dealerUuid'],
      dealerGroupUniqueName: json['dealerGroupUniqueName'],
      dealerGroupUuid: json['dealerGroupUuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFromProvider': idFromProvider,
      'remoteDealerId': remoteDealerId,
      'dealerName': dealerName,
      'remoteSku': remoteSku,
      'experience': experience,
      'rooftopUniqueName': rooftopUniqueName,
      'rooftopUuid': rooftopUuid,
      'dealerUniqueName': dealerUniqueName,
      'dealerUuid': dealerUuid,
      'dealerGroupUniqueName': dealerGroupUniqueName,
      'dealerGroupUuid': dealerGroupUuid,
    };
  }
}
