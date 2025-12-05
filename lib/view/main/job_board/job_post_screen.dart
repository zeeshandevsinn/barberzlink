import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/models/job_model.dart';
import 'package:barberzlink/widgets/chip_section.dart';
import 'package:barberzlink/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/composer_field.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController =
      TextEditingController(text: 'Lead Master Barber');
  final TextEditingController _companyController =
      TextEditingController(text: 'Legends Grooming Lounge');

  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _taglineController = TextEditingController(
      text: 'Luxury grooming collective scaling nationwide.');
  final TextEditingController _locationController =
      TextEditingController(text: 'Atlanta, GA (Hybrid)');
  final TextEditingController _salaryController =
      TextEditingController(text: '\$80k - \$95k + tips');
  final TextEditingController _descriptionController = TextEditingController(
      text:
          'Champion the craft, lead culture, and keep our VIP waitlist short by crafting signature looks.');
  final TextEditingController _aboutController = TextEditingController(
      text:
          'Legends blends hospitality, creative studios, and top-tier grooming talent into a modern residency experience.');
  final TextEditingController _newResponsibilityController =
      TextEditingController();
  final TextEditingController _mustHaveController = TextEditingController();
  final TextEditingController _niceToHaveController = TextEditingController();

  final List<String> _employmentTypes = const [
    'Full-time',
    'Part-time',
    'Contract',
    'Freelance collective',
  ];
  String _selectedEmploymentType = 'Full-time';
  double _experienceLevel = 2; // 0-entry, 1-mid, 2-senior, 3-director

  final List<String> _responsibilities = [
    'Host advanced cut labs & coach junior barbers.',
    'Lead premium consultations end-to-end.',
    'Capture content with creative team weekly.',
  ];

  final List<String> _mustHaveSkills = [
    'Active state license',
    '5+ years premium clientele',
  ];

  final List<String> _niceToHaves = [
    'Content creation or education experience',
    'Multi-state license transfers',
  ];

  final List<String> _perkOptions = [
    "Competitive Pay Structure",
    "Flexible Scheduling",
    "High Walk-In Traffic",
    "Marketing & Promotive",
    "Provided Supplies & Amenities",
    "Comfortable & Updated Workspace",
    "Education & Career Growth",
    "Business Support",
    "Stability & Safety",
    "Community & Team Advantages",
    "Client Growth Opportunities",
    "Hiring Flyers",
  ];

  final Set<String> _selectedPerks = {};
  int _currentStep = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _taglineController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _aboutController.dispose();
    _newResponsibilityController.dispose();
    _mustHaveController.dispose();
    _niceToHaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildProgressStepper(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: _buildStepContent(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Post a Job',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            icon: Icon(Icons.remove_red_eye_outlined,
                color: Colors.white, size: 20.sp),
            onPressed: _openPreviewSheet,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressStepper() {
    final steps = ['Basics', 'Details', 'Requirements', 'Preview'];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.h,
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / steps.length,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isActive = index == _currentStep;
              final isCompleted = index < _currentStep;

              return Column(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFF1A1A1A)
                          : isActive
                              ? const Color(0xFF1A1A1A)
                              : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: isCompleted
                        ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                        : Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isActive
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    step,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive
                          ? const Color(0xFF1A1A1A)
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStepBasics();
      case 1:
        return _buildStepDetails();
      case 2:
        return _buildStepRequirements();
      case 3:
        return _buildStepPreview();
      default:
        return _buildStepBasics();
    }
  }

  Widget _buildStepBasics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Job Basics',
          subtitle: 'Start with the essential information',
        ),
        SizedBox(height: 24.h),
        _buildFormField(
          label: 'Job Title',
          controller: _titleController,
          icon: Icons.work_outline,
        ),
        SizedBox(height: 16.h),
        _buildFormField(
          label: 'Company / Shop',
          controller: _companyController,
          icon: Icons.business_center_outlined,
        ),
        SizedBox(height: 16.h),
        _buildFormField(
          label: 'Company Email / Recruiter Email',
          controller: _companyEmailController,
          icon: Icons.email,
        ),
        SizedBox(height: 16.h),
        _buildFormField(
          label: 'Tagline',
          controller: _taglineController,
          icon: Icons.tag_faces_outlined,
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: 'Location',
                controller: _locationController,
                icon: Icons.location_on_outlined,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildFormField(
                label: 'Compensation',
                controller: _salaryController,
                icon: Icons.attach_money_outlined,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        _buildSectionHeader(
          title: 'Employment Type',
          subtitle: 'Choose how this role works',
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _employmentTypes.map((type) {
            final isSelected = _selectedEmploymentType == type;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedEmploymentType = type),
              selectedColor: const Color(0xFF1A1A1A),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: Colors.grey.shade100,
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildStepDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Role Details',
          subtitle: 'Describe the position and team',
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Experience Level',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    _experienceLabel(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Slider(
                value: _experienceLevel,
                min: 0,
                max: 3,
                divisions: 3,
                onChanged: (value) => setState(() => _experienceLevel = value),
                activeColor: const Color(0xFF1A1A1A),
                inactiveColor: Colors.grey.shade300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Apprentice', 'Junior', 'Senior', 'Master']
                    .map((label) => Text(
                          label,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildFormField(
          label: 'Role Summary',
          controller: _descriptionController,
          maxLines: 4,
          icon: Icons.description_outlined,
        ),
        SizedBox(height: 16.h),
        _buildFormField(
          label: 'About the Team',
          controller: _aboutController,
          maxLines: 4,
          icon: Icons.people_outline,
        ),
      ],
    );
  }

  Widget _buildStepRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Role Requirements',
          subtitle: 'Define responsibilities and qualifications',
        ),
        SizedBox(height: 24.h),

        // Responsibilities
        _buildListSection(
          title: 'Responsibilities',
          items: _responsibilities,
          controller: _newResponsibilityController,
          hint: 'Add responsibility',
          onAdd: () =>
              _handleAddItem(_responsibilities, _newResponsibilityController),
        ),
        SizedBox(height: 24.h),

        // Must Haves
        ChipSection(
          title: 'Must Haves',
          subtitle: 'Essential qualifications',
          items: _mustHaveSkills,
          controller: _mustHaveController,
          hint: 'Add requirement',
          onAdd: () => _handleAddItem(_mustHaveSkills, _mustHaveController),
          color: const Color(0xFFFFE6E6),
          textColor: Colors.red.shade700,
          onDeleteItem: (item) {
            setState(() => _mustHaveSkills.remove(item));
          },
        ),
        SizedBox(height: 24.h),

        // Nice to Haves
        ChipSection(
          title: 'Nice to Haves',
          subtitle: 'Bonus qualifications',
          items: _niceToHaves,
          controller: _niceToHaveController,
          hint: 'Add nice to have',
          onAdd: () => _handleAddItem(_niceToHaves, _niceToHaveController),
          color: const Color(0xFFE6F3FF),
          textColor: Colors.blue.shade700,
          onDeleteItem: (item) {
            setState(() => _niceToHaves.remove(item));
          },
        ),
        SizedBox(height: 24.h),

        // Perks
        _buildSectionHeader(
          title: 'Perks & Benefits',
          subtitle: 'What makes this role special',
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _perkOptions.map((perk) {
            final isSelected = _selectedPerks.contains(perk);
            return FilterChip(
              selected: isSelected,
              label: Text(perk),
              onSelected: (_) {
                setState(() {
                  if (_selectedPerks.contains(perk)) {
                    _selectedPerks.remove(perk);
                  } else {
                    _selectedPerks.add(perk);
                  }
                });
              },
              selectedColor: const Color(0xFF1A1A1A),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: Colors.grey.shade100,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStepPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Live Preview',
          subtitle: 'How your job will appear to barbers',
        ),
        SizedBox(height: 24.h),
        JobCard(
          job: _buildPreviewJob(),
          isSaved: false,
          isApplied: false,
          onTap: () {},
          onToggleSave: () {},
          onApply: () {},
          margin: EdgeInsets.zero,
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle,
                  color: Colors.green.shade600, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Your job post is ready to go live! Review the preview and make any final adjustments.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
      {required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          prefixIcon:
              icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildListSection({
    required String title,
    required List<String> items,
    required TextEditingController controller,
    required String hint,
    required VoidCallback onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.h),
        ...items.map((item) => _buildListItem(item, onDelete: () {
              setState(() => items.remove(item));
            })),
        SizedBox(height: 12.h),
        ComposerField(
          controller: controller,
          hint: hint,
          onAdd: onAdd,
        ),
      ],
    );
  }

  Widget _buildListItem(String text, {required VoidCallback onDelete}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 16.sp, color: Colors.grey.shade500),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            if (_currentStep > 0) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _currentStep--),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              flex: _currentStep > 0 ? 1 : 2,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentStep < 3) {
                    setState(() => _currentStep++);
                  } else {
                    _submitJob();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A1A),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  _currentStep == 3 ? 'Post Job' : 'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _experienceLabel() {
    switch (_experienceLevel.round()) {
      case 0:
        return 'Apprentice Level';
      case 1:
        return 'Junior Level';
      case 2:
        return 'Senior Level';
      default:
        return 'Master Level';
    }
  }

  void _handleAddItem(List<String> target, TextEditingController controller) {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    setState(() {
      target.add(value);
      controller.clear();
    });
  }

  JobModel _buildPreviewJob() {
    return JobModel(
      id: 'preview',
      title: _titleController.text,
      companyName: _companyController.text,
      companyEmail: _companyEmailController.text,
      companyTagline: _taglineController.text,
      location: _locationController.text,
      logo: AppStrings.barbershopImage,
      employmentType: _selectedEmploymentType,
      experienceLevel: _experienceLabel(),
      salaryRange: _salaryController.text,
      postedOn: DateTime.now(),
      applicants: 0,
      description: _descriptionController.text,
      aboutCompany: _aboutController.text,
      responsibilities: List.from(_responsibilities),
      mustHaves: List.from(_mustHaveSkills),
      goodToHaves: List.from(_niceToHaves),
      perks: _selectedPerks.toList(),
      cultureHighlights: [
        'Intentional mentorship',
        if (_selectedPerks.contains('Equity path')) 'Ownership potential',
      ],
      tags: [
        _selectedEmploymentType,
        _experienceLabel(),
        ..._selectedPerks.take(2),
      ],
      isPromoted: true,
      isSaved: false,
      isApplied: false,
      isOwnerPosting: true,
      isEasyApply: true,
    );
  }

  void _submitJob() {
    // Handle job submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Job posted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _openPreviewSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 50.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20.w,
              right: 20.w,
              top: 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Job Preview',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: JobCard(
                      job: _buildPreviewJob(),
                      isSaved: false,
                      isApplied: false,
                      onTap: () {},
                      onToggleSave: () {},
                      onApply: () {},
                      margin: EdgeInsets.zero,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 32.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Close Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
