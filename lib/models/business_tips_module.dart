class BusinessTipsModel {
  /// 1️⃣ Business Information
  final String businessName;
  final List<String> typeOfBusiness;
  final String website;
  final String contactName;
  final String email;
  final String phone;
  final String address;
  final List<String> statesServed;

  /// 2️⃣ Services For Barbers
  final String serviceOfferedFor; // Barbers or Barbershops
  final List<String> idealClients;
  final List<String> minimumRequirements;

  /// 3️⃣ Products
  final List<String> productsOffered;
  final String mainProducts;

  /// 4️⃣ Special Offers
  final bool discountAvailable;
  final String? specialOffers;
  final String? promoCode;
  final String? offerDates;

  /// 5️⃣ Licensing
  final bool licensed;
  final String licenses;
  final List<String> supportingDocuments;

  /// 6️⃣ Marketing
  final List<String> displayPreferences;
  final String profileDescription;
  final String? logoUrl;

  /// 7️⃣ Consent
  final bool consentGiven;

  BusinessTipsModel({
    required this.businessName,
    required this.typeOfBusiness,
    required this.website,
    required this.contactName,
    required this.email,
    required this.phone,
    required this.address,
    required this.statesServed,
    required this.serviceOfferedFor,
    required this.idealClients,
    required this.minimumRequirements,
    required this.productsOffered,
    required this.mainProducts,
    required this.discountAvailable,
    this.specialOffers,
    this.promoCode,
    this.offerDates,
    required this.licensed,
    required this.licenses,
    required this.supportingDocuments,
    required this.displayPreferences,
    required this.profileDescription,
    this.logoUrl,
    required this.consentGiven,
  });

  /// 🔄 Convert to JSON (for API)
  Map<String, dynamic> toJson() {
    return {
      "businessName": businessName,
      "typeOfBusiness": typeOfBusiness,
      "website": website,
      "contactName": contactName,
      "email": email,
      "phone": phone,
      "address": address,
      "statesServed": statesServed,
      "serviceOfferedFor": serviceOfferedFor,
      "idealClients": idealClients,
      "minimumRequirements": minimumRequirements,
      "productsOffered": productsOffered,
      "mainProducts": mainProducts,
      "discountAvailable": discountAvailable,
      "specialOffers": specialOffers,
      "promoCode": promoCode,
      "offerDates": offerDates,
      "licensed": licensed,
      "licenses": licenses,
      "supportingDocuments": supportingDocuments,
      "displayPreferences": displayPreferences,
      "profileDescription": profileDescription,
      "logoUrl": logoUrl,
      "consentGiven": consentGiven,
    };
  }

  /// 🔄 Parse from JSON
  factory BusinessTipsModel.fromJson(Map<String, dynamic> json) {
    return BusinessTipsModel(
      businessName: json["businessName"],
      typeOfBusiness: List<String>.from(json["typeOfBusiness"]),
      website: json["website"],
      contactName: json["contactName"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      statesServed: List<String>.from(json["statesServed"]),
      serviceOfferedFor: json["serviceOfferedFor"],
      idealClients: List<String>.from(json["idealClients"]),
      minimumRequirements: List<String>.from(json["minimumRequirements"]),
      productsOffered: List<String>.from(json["productsOffered"]),
      mainProducts: json["mainProducts"],
      discountAvailable: json["discountAvailable"],
      specialOffers: json["specialOffers"],
      promoCode: json["promoCode"],
      offerDates: json["offerDates"],
      licensed: json["licensed"],
      licenses: json["licenses"],
      supportingDocuments: List<String>.from(json["supportingDocuments"]),
      displayPreferences: List<String>.from(json["displayPreferences"]),
      profileDescription: json["profileDescription"],
      logoUrl: json["logoUrl"],
      consentGiven: json["consentGiven"],
    );
  }
}
