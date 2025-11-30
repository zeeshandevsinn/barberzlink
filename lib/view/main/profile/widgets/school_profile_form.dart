import 'dart:io';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/view/main/profile/widgets/Profile_form_section.dart';
import 'package:barberzlink/view/main/profile/widgets/custom_image_picker.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:flutter/material.dart';

class SchoolProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;
  final File? mainImage;
  final List<File> galleryImages;
  final String selectedState;
  final List<String> states;

  final VoidCallback onSave;
  final VoidCallback onPickMainImage;
  final VoidCallback onPickGalleryImages;
  final ValueChanged<String?> onStateChanged;

  const SchoolProfileForm({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.mainImage,
    required this.galleryImages,
    required this.selectedState,
    required this.states,
    required this.onSave,
    required this.onPickMainImage,
    required this.onPickGalleryImages,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final fields = [
      FieldConfig(
        controller: controllers['firstName']!,
        label: 'Contact First Name',
        icon: Icons.person,
      ),
      FieldConfig(
        controller: controllers['lastName']!,
        label: 'Contact Last Name',
        icon: Icons.person_outline,
      ),
      FieldConfig(
        controller: controllers['email']!,
        label: 'User Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      FieldConfig(
        controller: controllers['username']!,
        label: 'Username',
        icon: Icons.account_circle_outlined,
      ),
      FieldConfig(
        controller: controllers['password']!,
        label: 'Password',
        icon: Icons.lock_outline,
        isPassword: true,
      ),
      FieldConfig(
        controller: controllers['schoolName']!,
        label: 'School Name',
        icon: Icons.school_outlined,
      ),
      FieldConfig(
        controller: controllers['address']!,
        label: 'Full Address',
        icon: Icons.location_on_outlined,
      ),
      FieldConfig(
        controller: controllers['city']!,
        label: 'City',
        icon: Icons.location_city,
      ),
      FieldConfig(
        controller: controllers['about']!,
        label: 'About the School',
        icon: Icons.notes_outlined,
        maxLines: 4,
      ),
      FieldConfig(
        controller: controllers['phone']!,
        label: 'Phone',
        icon: Icons.phone,
        keyboardType: TextInputType.phone,
      ),
      FieldConfig(
        controller: controllers['website']!,
        label: 'Website',
        icon: Icons.language,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      FieldConfig(
        controller: controllers['instagram']!,
        label: 'Instagram',
        icon: Icons.camera_alt_outlined,
        isRequired: false,
      ),
    ];

    return ProfileFormSection(
      formKey: formKey,
      fields: fields,
      extraChildren: [
        _buildStateDropdown(context),
        const SizedBox(height: 18),
        CustomImagePicker(
          title: 'Campus Main Image',
          helper: 'Recommended 1200x600 hero image.',
          file: mainImage,
          onTap: onPickMainImage,
        ),
        const SizedBox(height: 18),
        _buildGallerySection(
          context: context,
          title: 'Campus Gallery (up to 5)',
          files: galleryImages,
          onTap: onPickGalleryImages,
        ),
      ],
      onSave: onSave,
    );
  }

  Widget _buildStateDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('State', style: AppTextStyle.semiBold(fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedState,
              isExpanded: true,
              items: states
                  .map((state) => DropdownMenuItem(
                        value: state,
                        child: Text(state, style: AppTextStyle.medium()),
                      ))
                  .toList(),
              onChanged: onStateChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGallerySection({
    required BuildContext context,
    required String title,
    required List<File> files,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.semiBold(fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: files.isEmpty
              ? const DottedBorderContainer(text: 'Tap to upload gallery items')
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: files
                      .map((file) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(file,
                                width: 80, height: 80, fit: BoxFit.cover),
                          ))
                      .toList(),
                ),
        ),
      ],
    );
  }
}
