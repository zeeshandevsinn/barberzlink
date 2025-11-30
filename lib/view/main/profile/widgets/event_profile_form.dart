import 'dart:io';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/view/main/profile/widgets/Profile_form_section.dart';
import 'package:barberzlink/view/main/profile/widgets/custom_image_picker.dart';
import 'package:flutter/material.dart';

class EventProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;
  final File? heroImage;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  final VoidCallback onSave;
  final VoidCallback onPickHeroImage;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;

  const EventProfileForm({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.heroImage,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.onSave,
    required this.onPickHeroImage,
    required this.onPickStartDate,
    required this.onPickEndDate,
    required this.onPickStartTime,
    required this.onPickEndTime,
  });

  @override
  Widget build(BuildContext context) {
    final fields = [
      FieldConfig(
        controller: controllers['eventName']!,
        label: 'Event Name',
        icon: Icons.event_outlined,
      ),
      FieldConfig(
        controller: controllers['hostName']!,
        label: 'Host Name',
        icon: Icons.person,
      ),
      FieldConfig(
        controller: controllers['location']!,
        label: 'Location',
        icon: Icons.location_on_outlined,
        maxLines: 2,
      ),
      FieldConfig(
        controller: controllers['website']!,
        label: 'Website / Tickets Link',
        icon: Icons.link,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      FieldConfig(
        controller: controllers['instagram']!,
        label: 'Instagram Handle',
        icon: Icons.camera_alt_outlined,
        isRequired: false,
      ),
    ];

    return ProfileFormSection(
      formKey: formKey,
      fields: fields,
      extraChildren: [
        _buildDateTimeRow(context, 'Start', startDate, startTime,
            onPickStartDate, onPickStartTime),
        const SizedBox(height: 12),
        _buildDateTimeRow(
            context, 'End', endDate, endTime, onPickEndDate, onPickEndTime),
        const SizedBox(height: 18),
        CustomImagePicker(
          title: 'Event Hero Image',
          helper: 'Tap to refresh flyers or hero artwork.',
          file: heroImage,
          onTap: onPickHeroImage,
        ),
      ],
      onSave: onSave,
    );
  }

  Widget _buildDateTimeRow(BuildContext context, String label, DateTime? date,
      TimeOfDay? time, VoidCallback onDateTap, VoidCallback onTimeTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date & Time', style: AppTextStyle.semiBold(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onDateTap,
                icon: const Icon(Icons.calendar_today_outlined,
                    color: AppColors.black),
                label: Text(
                  date == null
                      ? 'Select Date'
                      : '${date.month}/${date.day}/${date.year}',
                  style: AppTextStyle.medium(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onTimeTap,
                icon: const Icon(Icons.access_time, color: AppColors.black),
                label: Text(
                  time == null ? 'Select Time' : time.format(context),
                  style: AppTextStyle.medium(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
