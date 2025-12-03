import 'package:barberzlink/helper/functions.dart';
import 'package:flutter/foundation.dart';

@immutable
class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String companyEmail;
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
    required this.companyEmail,
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
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    }
    if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    }
    if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    }
    if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    }
    return 'Just now';
  }

  JobModel copyWith({
    String? id,
    String? title,
    String? companyName,
    String? companyEmail,
    String? companyTagline,
    String? location,
    String? logo,
    bool? isRemoteFriendly,
    String? employmentType,
    String? experienceLevel,
    String? salaryRange,
    DateTime? postedOn,
    int? applicants,
    String? description,
    String? aboutCompany,
    List<String>? responsibilities,
    List<String>? mustHaves,
    List<String>? goodToHaves,
    List<String>? perks,
    List<String>? cultureHighlights,
    List<String>? tags,
    bool? isPromoted,
    bool? isSaved,
    bool? isApplied,
    bool? isOwnerPosting,
    bool? isEasyApply,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      companyName: companyName ?? this.companyName,
      companyTagline: companyTagline ?? this.companyTagline,
      location: location ?? this.location,
      logo: logo ?? this.logo,
      isRemoteFriendly: isRemoteFriendly ?? this.isRemoteFriendly,
      employmentType: employmentType ?? this.employmentType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      salaryRange: salaryRange ?? this.salaryRange,
      postedOn: postedOn ?? this.postedOn,
      applicants: applicants ?? this.applicants,
      description: description ?? this.description,
      aboutCompany: aboutCompany ?? this.aboutCompany,
      responsibilities: responsibilities ?? this.responsibilities,
      mustHaves: mustHaves ?? this.mustHaves,
      goodToHaves: goodToHaves ?? this.goodToHaves,
      perks: perks ?? this.perks,
      cultureHighlights: cultureHighlights ?? this.cultureHighlights,
      tags: tags ?? this.tags,
      isPromoted: isPromoted ?? this.isPromoted,
      isSaved: isSaved ?? this.isSaved,
      isApplied: isApplied ?? this.isApplied,
      isOwnerPosting: isOwnerPosting ?? this.isOwnerPosting,
      isEasyApply: isEasyApply ?? this.isEasyApply,
      companyEmail: companyEmail ?? this.companyEmail,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'companyName': companyName,
      'companyTagline': companyTagline,
      'location': location,
      'logo': logo,
      'isRemoteFriendly': isRemoteFriendly,
      'employmentType': employmentType,
      'experienceLevel': experienceLevel,
      'salaryRange': salaryRange,
      'postedOn': postedOn.millisecondsSinceEpoch,
      'applicants': applicants,
      'description': description,
      'aboutCompany': aboutCompany,
      'responsibilities': responsibilities,
      'mustHaves': mustHaves,
      'goodToHaves': goodToHaves,
      'perks': perks,
      'cultureHighlights': cultureHighlights,
      'tags': tags,
      'isPromoted': isPromoted,
      'isSaved': isSaved,
      'isApplied': isApplied,
      'isOwnerPosting': isOwnerPosting,
      'isEasyApply': isEasyApply,
    };
  }

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      title: json['title'] as String,
      companyName: json['companyName'] as String,
      companyTagline: json['companyTagline'] as String,
      location: json['location'] as String,
      logo: json['logo'] as String,
      isRemoteFriendly: json['isRemoteFriendly'] as bool,
      employmentType: json['employmentType'] as String,
      experienceLevel: json['experienceLevel'] as String,
      salaryRange: json['salaryRange'] as String,
      postedOn: DateTime.fromMillisecondsSinceEpoch(json['postedOn'] as int),
      applicants: json['applicants'] as int,
      description: json['description'] as String,
      aboutCompany: json['aboutCompany'] as String,
      responsibilities: List<String>.from(json['responsibilities'] as List),
      mustHaves: List<String>.from(json['mustHaves'] as List),
      goodToHaves: List<String>.from(json['goodToHaves'] as List),
      perks: List<String>.from(json['perks'] as List),
      cultureHighlights: List<String>.from(json['cultureHighlights'] as List),
      tags: List<String>.from(json['tags'] as List),
      isPromoted: json['isPromoted'] as bool? ?? false,
      isSaved: json['isSaved'] as bool? ?? false,
      isApplied: json['isApplied'] as bool? ?? false,
      isOwnerPosting: json['isOwnerPosting'] as bool? ?? false,
      isEasyApply: json['isEasyApply'] as bool? ?? false,
      companyEmail: json['companyEmail'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is JobModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            title == other.title &&
            companyName == other.companyName &&
            companyTagline == other.companyTagline &&
            location == other.location &&
            companyEmail == other.companyEmail &&
            logo == other.logo &&
            isRemoteFriendly == other.isRemoteFriendly &&
            employmentType == other.employmentType &&
            experienceLevel == other.experienceLevel &&
            salaryRange == other.salaryRange &&
            postedOn == other.postedOn &&
            applicants == other.applicants &&
            description == other.description &&
            aboutCompany == other.aboutCompany &&
            listEquals(responsibilities, other.responsibilities) &&
            listEquals(mustHaves, other.mustHaves) &&
            listEquals(goodToHaves, other.goodToHaves) &&
            listEquals(perks, other.perks) &&
            listEquals(cultureHighlights, other.cultureHighlights) &&
            listEquals(tags, other.tags) &&
            isPromoted == other.isPromoted &&
            isSaved == other.isSaved &&
            isApplied == other.isApplied &&
            isOwnerPosting == other.isOwnerPosting &&
            isEasyApply == other.isEasyApply);
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      title,
      companyName,
      companyEmail,
      companyTagline,
      location,
      logo,
      isRemoteFriendly,
      employmentType,
      experienceLevel,
      salaryRange,
      postedOn,
      applicants,
      description,
      aboutCompany,
      Object.hashAll(responsibilities),
      Object.hashAll(mustHaves),
      Object.hashAll(goodToHaves),
      Object.hashAll(perks),
      Object.hashAll(cultureHighlights),
      Object.hashAll(tags),
      isPromoted,
      isSaved,
      isApplied,
      isOwnerPosting,
      isEasyApply,
    ]);
  }

  @override
  String toString() {
    return 'JobModel{id: $id, title: $title, company: $companyName, companyEmail: $companyEmail, location: $location, applicants: $applicants, saved: $isSaved, applied: $isApplied}';
  }

  // Utility methods for common operations
  bool matchesSearch(String query) {
    final searchTerm = query.toLowerCase();
    return title.toLowerCase().contains(searchTerm) ||
        companyName.toLowerCase().contains(searchTerm) ||
        location.toLowerCase().contains(searchTerm) ||
        tags.any((tag) => tag.toLowerCase().contains(searchTerm)) ||
        description.toLowerCase().contains(searchTerm);
  }

  bool matchesFilters({
    Set<String>? employmentTypes,
    Set<String>? experienceLevels,
    bool? remoteOnly,
    bool? easyApplyOnly,
  }) {
    if (employmentTypes != null && employmentTypes.isNotEmpty) {
      if (!employmentTypes.contains(employmentType)) return false;
    }

    if (experienceLevels != null && experienceLevels.isNotEmpty) {
      if (!experienceLevels.contains(experienceLevel)) return false;
    }

    if (remoteOnly == true && !isRemoteFriendly) return false;
    if (easyApplyOnly == true && !isEasyApply) return false;

    return true;
  }

  // Convenience constructor for creating sample data
  factory JobModel.sample({
    String? id,
    String? title,
    String? companyName,
    String? companyEmail,
    String? location,
    bool isRemoteFriendly = false,
    String employmentType = 'Full-time',
    String experienceLevel = 'Mid-level',
    String salaryRange = '\$60k - \$80k',
    int applicants = 0,
    bool isSaved = false,
    bool isApplied = false,
  }) {
    final now = DateTime.now();
    return JobModel(
      id: id ?? 'job_${now.millisecondsSinceEpoch}',
      title: title ?? 'Senior Barber',
      companyName: companyName ?? 'Elite Barbershop',
      companyEmail: companyEmail ?? AppHelper.adminEmail,
      companyTagline: 'Premium grooming experience since 2015',
      location: location ?? 'New York, NY',
      logo: 'assets/logos/barbershop.png',
      isRemoteFriendly: isRemoteFriendly,
      employmentType: employmentType,
      experienceLevel: experienceLevel,
      salaryRange: salaryRange,
      postedOn: now.subtract(const Duration(days: 2)),
      applicants: applicants,
      description:
          'We are looking for an experienced barber to join our premium grooming team. The ideal candidate should have excellent technical skills and a passion for customer service.',
      aboutCompany:
          'Elite Barbershop has been providing premium grooming services for over 8 years. We believe in quality, precision, and creating a welcoming environment for our clients.',
      responsibilities: [
        'Provide high-quality haircuts and grooming services',
        'Maintain cleanliness and organization of work station',
        'Build and maintain client relationships',
        'Stay updated with latest trends and techniques',
      ],
      mustHaves: [
        '3+ years of professional barbering experience',
        'State barber license',
        'Strong communication skills',
      ],
      goodToHaves: [
        'Experience with classic and modern styles',
        'Knowledge of beard grooming techniques',
        'Customer service experience',
      ],
      perks: [
        'Health insurance',
        'Paid time off',
        'Commission opportunities',
        'Professional development',
      ],
      cultureHighlights: [
        'Team-oriented environment',
        'Continuous learning culture',
        'Focus on work-life balance',
      ],
      tags: [
        employmentType,
        experienceLevel,
        if (isRemoteFriendly) 'Remote',
        'Barber',
        'Grooming',
      ],
      isSaved: isSaved,
      isApplied: isApplied,
    );
  }
}
