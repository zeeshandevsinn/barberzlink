class StateProfileModel {
  final String stateName;
  final String boardName;
  final String websiteLink;
  final String transferLink;
  final String testingSiteLink;
  final String militaryPolicyLink;

  StateProfileModel({
    required this.stateName,
    required this.boardName,
    required this.websiteLink,
    required this.transferLink,
    required this.testingSiteLink,
    required this.militaryPolicyLink,
    required String stateCode,
    required String licenseInfo,
    required String requirements,
  });
}
