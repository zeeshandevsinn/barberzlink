import 'package:flutter/material.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/custom_textfield.dart';

class ProfileFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<FieldConfig> fields;
  final List<Widget> extraChildren;
  final VoidCallback onSave;

  const ProfileFormSection({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSave,
    this.extraChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...fields.map(
              (field) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomTextField(
                  controller: field.controller,
                  label: field.label,
                  icon: field.icon,
                  keyboardType: field.keyboardType,
                  isPasswordField: field.isPassword,
                  maxLines: field.maxLines,
                  isTitle: true,
                  titleName: field.label,
                  validator: field.isRequired ? null : (value) => null,
                ),
              ),
            ),
            ...extraChildren,
            const SizedBox(height: 24),
            CustomButton(
              onTap: onSave,
              buttonText: 'Save Changes',
            ),
          ],
        ),
      ),
    );
  }
}

class FieldConfig {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isPassword;
  final bool isRequired;

  const FieldConfig({
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.isPassword = false,
    this.isRequired = true,
  });
}
