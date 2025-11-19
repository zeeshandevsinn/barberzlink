import 'dart:io';

import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/custom_textfield.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class NewProductRegistration extends StatefulWidget {
  const NewProductRegistration({super.key});

  @override
  State<NewProductRegistration> createState() => _NewProductRegistrationState();
}

class _NewProductRegistrationState extends State<NewProductRegistration> {
  // Form controllers
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _shortDescController = TextEditingController();
  final TextEditingController _standoutController = TextEditingController();
  final TextEditingController _promoLinkController = TextEditingController();

  // Checkboxes
  bool _appFeature = true;
  bool _socialMediaPost = true;

  // Date picker
  DateTime? _startDate;

  // Media upload
  File? _mediaFile;
  final ImagePicker _picker = ImagePicker();

  Widget _buildLabel(String label, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            if (isRequired)
              const TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickMedia() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _mediaFile = File(picked.path));
      }
    } else {
      openAppSettings();
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: kIsWeb
            ? AppBar(
                title: Text(
                  'Product Registration',
                  style: AppTextStyle.semiBold(),
                ),
                centerTitle: true,
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: 'Product Registration',
                  isBack: true,
                ),
              ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Optional header image
              Container(
                color: Colors.grey.shade200,
                child: Image.asset(
                  AppStrings.newProductImage,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),
              Text(
                'Product Registration',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join Barberz Link and grow your visibility online!',
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Fill the form below to promote your product",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Company Info
                        _buildLabel("Company Info", true),

                        const SizedBox(height: 30),
                        Column(
                          spacing: 15,
                          children: [
                            CustomTextField(
                              controller: _companyController,
                              label: "Company Name",
                              isTitle: true,
                              titleName: "Company Name",
                            ),
                            CustomTextField(
                              controller: _contactController,
                              label: "Contact Person",
                              isTitle: true,
                              titleName: "Contact Person",
                            ),
                            CustomTextField(
                              controller: _emailPhoneController,
                              label: "Email / Phone",
                              isTitle: true,
                              titleName: "Email / Phone",
                            ),
                            CustomTextField(
                              controller: _websiteController,
                              label: "Website / Social Media",
                              isTitle: true,
                              titleName: "Website / Social Media",
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Product Details
                        _buildLabel("Product Details", true),

                        const SizedBox(height: 30),

                        Column(
                          spacing: 15,
                          children: [
                            CustomTextField(
                              controller: _productNameController,
                              label: "Product Name",
                              isTitle: true,
                              titleName: "Product Name",
                            ),
                            CustomTextField(
                              controller: _productTypeController,
                              label: "Product Type",
                              isTitle: true,
                              titleName: "Product Type",
                            ),
                            CustomTextField(
                              controller: _shortDescController,
                              label: "Short Description",
                              isTitle: true,
                              titleName: "Short Description",
                              maxLines: 3,
                            ),
                            CustomTextField(
                              controller: _standoutController,
                              label: "What makes your product stand out?",
                              isTitle: true,
                              titleName: "Product Standout",
                              maxLines: 3,
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Media Upload
                        _buildLabel("Upload Photo/Video", true),

                        const SizedBox(height: 30),
                        _mediaFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(_mediaFile!,
                                    width: double.infinity,
                                    height: 160,
                                    fit: BoxFit.cover),
                              )
                            : GestureDetector(
                                onTap: _pickMedia,
                                child: DottedBorderContainer(
                                  text:
                                      "Drop your file here or click here to upload\nYou can upload 1 file",
                                ),
                              ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _promoLinkController,
                          label: "Link to Promo Material (Optional)",
                          isTitle: true,
                          titleName: "Promo Link",
                        ),
                        const SizedBox(height: 30),

                        // Promotion Options
                        _buildLabel("Promotion Options", true),

                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: AppColors.white,
                                activeColor: AppColors.black,
                                value: _appFeature,
                                onChanged: (v) =>
                                    setState(() => _appFeature = v!)),
                            const Text("App Feature"),
                            const SizedBox(width: 20),
                            Checkbox(
                                checkColor: AppColors.white,
                                activeColor: AppColors.black,
                                value: _socialMediaPost,
                                onChanged: (v) =>
                                    setState(() => _socialMediaPost = v!)),
                            const Text("Social Media Post"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Preferred Start Date: "),
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: _pickDate,
                                  child: Text(
                                    _startDate == null
                                        ? "Select Date"
                                        : DateFormat.yMMMd()
                                            .format(_startDate!),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Submit Button

                        CustomButton(onTap: () {}, buttonText: "SUBMIT")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
