import 'dart:io';
import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/custom_textfield.dart';

class SchoolRegistrationScreen extends StatefulWidget {
  const SchoolRegistrationScreen({super.key});

  @override
  State<SchoolRegistrationScreen> createState() =>
      _SchoolRegistrationScreenState();
}

class _SchoolRegistrationScreenState extends State<SchoolRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _schoolName = TextEditingController();
  final TextEditingController _fullAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _website = TextEditingController();
  final TextEditingController _instagram = TextEditingController();

  // Dropdown values
  String _selectedState = "All States";

  // Image pickers
  File? _mainImage;
  final List<File> _galleryImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMainImage() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) setState(() => _mainImage = File(picked.path));
    } else {
      openAppSettings();
    }
  }

  Future<void> _pickGalleryImages() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final picked = await _picker.pickMultiImage();
      if (picked.isNotEmpty) {
        setState(() {
          _galleryImages.clear();
          _galleryImages.addAll(picked.take(5).map((e) => File(e.path)));
        });
      }
    } else {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: kIsWeb
            ? AppBar(
                title: Text(
                  'BarberShop Registration',
                  style: AppTextStyle.semiBold(),
                ),
                centerTitle: true,
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: 'School Registration',
                  isBack: true,
                )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Logo
              Image.asset(
                AppStrings.schoolImage,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                'School Registration',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Welcome to the School Registration page on Barberzlink.com — where education meets exposure in the world of barbering and cosmetology.",
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // User Info
                      CustomTextField(
                        isTitle: true,
                        titleName: 'First Name',
                        label: 'First Name',
                        icon: Icons.person,
                        controller: _firstName,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'Last Name',
                        label: 'Last Name',
                        icon: Icons.person_outline,
                        controller: _lastName,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'User Email',
                        label: 'User Email',
                        icon: Icons.email_outlined,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'Username',
                        label: 'Username',
                        icon: Icons.account_circle_outlined,
                        controller: _username,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'Password',
                        label: 'Password',
                        icon: Icons.lock_outline,
                        controller: _password,
                        isPasswordField: true,
                      ),
                      const SizedBox(height: 18),

                      // Shop Info
                      CustomTextField(
                        isTitle: true,
                        titleName: 'Name of School',
                        label: 'Name of School',
                        icon: Icons.school_outlined,
                        controller: _schoolName,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'School Full Address',
                        label: 'School Full Address',
                        icon: Icons.location_on_outlined,
                        controller: _fullAddress,
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'So we can improve your Google Listing',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'City',
                        label: 'City',
                        icon: Icons.location_city,
                        controller: _city,
                      ),
                      const SizedBox(height: 18),

                      // State Dropdown
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.black26),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedState,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                            dropdownColor: Colors.white,
                            items: Injections.instance.states
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(
                                      s,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() => _selectedState = value!);
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // About Field

                      CustomTextField(
                        isTitle: true,
                        titleName: 'About',
                        label: 'About',
                        controller: _about,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 18),

                      // Contact Info
                      CustomTextField(
                        isTitle: true,
                        titleName: 'Phone',
                        label: 'Phone',
                        icon: Icons.phone,
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        isTitle: true,
                        titleName: 'Website',
                        label: 'Website',
                        icon: Icons.language,
                        controller: _website,
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 18),

                      // Main Image
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'School Main Image',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickMainImage,
                        child: _mainImage == null
                            ? DottedBorderContainer(
                                text:
                                    "Drop your file here or click here to upload\nYou can upload up to 1 file",
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(_mainImage!,
                                    fit: BoxFit.cover, height: 150, width: 150),
                              ),
                      ),
                      const SizedBox(height: 30),

                      // Gallery Images
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'School Images (Up to 5)',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickGalleryImages,
                        child: _galleryImages.isEmpty
                            ? DottedBorderContainer(
                                text:
                                    "Drop your file here or click here to upload\nYou can upload up to 5 files",
                              )
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _galleryImages
                                    .map((file) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(file,
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover),
                                        ))
                                    .toList(),
                              ),
                      ),
                      const SizedBox(height: 30),

                      // Multiple locations

                      // Submit Button
                      CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              AppRoutes.goTo(context, AppRoutes.school_payment);
                            }
                          },
                          buttonText: "Submit"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _username.dispose();
    _password.dispose();
    _fullAddress.dispose();
    _city.dispose();
    _about.dispose();
    _phone.dispose();
    _website.dispose();
    _instagram.dispose();
    super.dispose();
  }
}
