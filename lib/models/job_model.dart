import 'package:flutter/foundation.dart';

@immutable
class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String companyTagline;
  final String location;
  final String logo;
  final bool isRemoteFriendly;
  final String employmentType;
  final String experienceLevel;
  final String salaryRange;
  final DateTime postedOn;
  final int applicants;
  final String description;
  final String aboutCompany;
  final List<String> responsibilities;
  final List<String> mustHaves;
  final List<String> goodToHaves;
  final List<String> perks;
  final List<String> cultureHighlights;
  final List<String> tags;
  final bool isPromoted;
  final bool isSaved;
  final bool isApplied;
  final bool isOwnerPosting;
  final bool isEasyApply;

  const JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.companyTagline,
    required this.location,
    required this.logo,
    required this.isRemoteFriendly,
    required this.employmentType,
    required this.experienceLevel,
    required this.salaryRange,
    required this.postedOn,
    required this.applicants,
    required this.description,
    required this.aboutCompany,
    required this.responsibilities,
    required this.mustHaves,
    required this.goodToHaves,
    required this.perks,
    required this.cultureHighlights,
    required this.tags,
    this.isPromoted = false,
    this.isSaved = false,
    this.isApplied = false,
    this.isOwnerPosting = false,
    this.isEasyApply = false,
  });

  String get postedLabel {
    final difference = DateTime.now().difference(postedOn);
    if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    }
    if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    }
    return '${difference.inMinutes}m ago';
  }

  JobModel copyWith({
    bool? isSaved,
    bool? isApplied,
  }) {
    return JobModel(
      id: id,
      title: title,
      companyName: companyName,
      companyTagline: companyTagline,
      location: location,
      logo: logo,
      isRemoteFriendly: isRemoteFriendly,
      employmentType: employmentType,
      experienceLevel: experienceLevel,
      salaryRange: salaryRange,
      postedOn: postedOn,
      applicants: applicants,
      description: description,
      aboutCompany: aboutCompany,
      responsibilities: responsibilities,
      mustHaves: mustHaves,
      goodToHaves: goodToHaves,
      perks: perks,
      cultureHighlights: cultureHighlights,
      tags: tags,
      isPromoted: isPromoted,
      isSaved: isSaved ?? this.isSaved,
      isApplied: isApplied ?? this.isApplied,
      isOwnerPosting: isOwnerPosting,
      isEasyApply: isEasyApply,
    );
  }
}
