import 'dart:io';
import 'package:flutter/material.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:barberzlink/view/main/profile/widgets/profile_form_section.dart';
import 'package:barberzlink/core/theme/app_theme.dart';

class BarberProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;
  final File? profileImage;
  final List<File> galleryImages;

  final VoidCallback onSave;
  final VoidCallback onPickProfileImage;
  final VoidCallback onPickGalleryImages;

  const BarberProfileForm({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.profileImage,
    required this.galleryImages,
    required this.onSave,
    required this.onPickProfileImage,
    required this.onPickGalleryImages,
  });

  @override
  Widget build(BuildContext context) {
    final fields = [
      FieldConfig(
        controller: controllers['firstName']!,
        label: 'First Name',
        icon: Icons.person,
      ),
      FieldConfig(
        controller: controllers['lastName']!,
        label: 'Last Name',
        icon: Icons.person_outline,
      ),
      FieldConfig(
        controller: controllers['username']!,
        label: 'Username',
        icon: Icons.alternate_email,
      ),
      FieldConfig(
        controller: controllers['password']!,
        label: 'User Password',
        icon: Icons.lock_outline,
        isPassword: true,
      ),
      FieldConfig(
        controller: controllers['fullName']!,
        label: 'Brand / Display Name',
        icon: Icons.badge_outlined,
      ),
      FieldConfig(
        controller: controllers['email']!,
        label: 'Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      FieldConfig(
        controller: controllers['phone']!,
        label: 'Phone',
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
      ),
      FieldConfig(
        controller: controllers['address']!,
        label: 'Full Address',
        icon: Icons.location_on_outlined,
      ),
      FieldConfig(
        controller: controllers['website']!,
        label: 'Website Link',
        icon: Icons.language,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      FieldConfig(
        controller: controllers['instagram']!,
        label: 'Instagram Username',
        icon: Icons.camera_alt_outlined,
      ),
      FieldConfig(
        controller: controllers['bio']!,
        label: 'About Your Craft',
        icon: Icons.description_outlined,
        maxLines: 4,
      ),
    ];

    return ProfileFormSection(
      formKey: formKey,
      fields: fields,
      extraChildren: [
        _ImageSection(
          title: 'Profile Picture',
          helper: '500x500 recommended · Tap to update',
          file: profileImage,
          onTap: onPickProfileImage,
        ),
        const SizedBox(height: 18),
        _GallerySection(
          title: 'Featured Work (up to 5)',
          helper: 'Showcase your best fades, beard work, or styles.',
          files: galleryImages,
          onTap: onPickGalleryImages,
        ),
      ],
      onSave: onSave,
    );
  }
}

class _ImageSection extends StatelessWidget {
  final String title;
  final String helper;
  final File? file;
  final VoidCallback onTap;

  const _ImageSection({
    required this.title,
    required this.helper,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.semiBold(fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: file == null
              ? const DottedBorderContainer(text: 'Drop or tap to upload')
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    file!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        if (helper.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            helper,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ]
      ],
    );
  }
}

class _GallerySection extends StatelessWidget {
  final String title;
  final String helper;
  final List<File> files;
  final VoidCallback onTap;

  const _GallerySection({
    required this.title,
    required this.helper,
    required this.files,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                      .map(
                        (f) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            f,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        if (helper.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            helper,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
