import 'dart:io';

import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/dotted_container.dart';

class BarberRegistrationScreen extends StatefulWidget {
  const BarberRegistrationScreen({super.key});

  @override
  State<BarberRegistrationScreen> createState() =>
      _BarberRegistrationScreenState();
}

class _BarberRegistrationScreenState extends State<BarberRegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullAddress = TextEditingController();

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
                fontSize: 16,
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: kIsWeb
            ? AppBar(
                title: Text(
                  'Barber Registration',
                  style: AppTextStyle.semiBold(),
                ),
                centerTitle: true,
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: CustomAppBar(
                  title: 'Barber Registration',
                  isBack: true,
                )),
        body: SingleChildScrollView(
          // allows scrolling
          child: Column(
            children: [
              Image.asset(
                AppStrings.barberImage,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                'Barber Registration',
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        // const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "Fill the form below to create an account.",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        // const SizedBox(height: 20),

                        // const SizedBox(height: 25),

                        // --- Submit Button ---

                        // Text Fields
                        CustomTextField(
                          controller: _firstNameController,
                          label: "First Name",
                          isTitle: true,
                          titleName: "First Name",
                        ),
                        CustomTextField(
                          controller: _lastNameController,
                          label: "Last Name",
                          isTitle: true,
                          titleName: "Last Name",
                        ),
                        CustomTextField(
                          controller: _usernameController,
                          label: "Username",
                          isTitle: true,
                          titleName: "Username",
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          label: "User Password",
                          isTitle: true,
                          titleName: "User Password",
                          isPasswordField: true,
                        ),
                        CustomTextField(
                          controller: _fullNameController,
                          label: "Full Name",
                          isTitle: true,
                          titleName: "Full Name",
                        ),
                        CustomTextField(
                          controller: _emailController,
                          label: "Email",
                          isTitle: true,
                          titleName: "Email",
                        ),
                        CustomTextField(
                          controller: _phoneController,
                          label: "Phone",
                          isTitle: true,
                          titleName: "Phone",
                        ),
                        CustomTextField(
                          controller: _fullAddress,
                          label: "Full Address",
                          isTitle: true,
                          titleName: "Full Address",
                        ),

                        // const SizedBox(height: 20),
                        // --- Upload Profile Picture ---
                        Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Your Profile Picture", true),
                              _mainImage != null
                                  ? Container(
                                      height: 160,
                                      width: 160,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(_mainImage!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: _pickMainImage,
                                      child: DottedBorderContainer(
                                        text:
                                            "Drop your file here or click here to upload\nYou can upload up to 1 file",
                                      ),
                                    ),

                              // const SizedBox(height: 8),
                              const Text("500x500",
                                  style: TextStyle(color: Colors.black54)),
                            ]),
                        // const SizedBox(height: 25),

                        // --- Upload Work Images ---
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Your Work", false),
                            _galleryImages.isNotEmpty
                                ? Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _galleryImages
                                        .map((file) => Container(
                                              height: 100,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(file,
                                                    width: 90,
                                                    height: 90,
                                                    fit: BoxFit.cover),
                                              ),
                                            ))
                                        .toList(),
                                  )
                                : GestureDetector(
                                    onTap: _pickGalleryImages,
                                    child: DottedBorderContainer(
                                      text:
                                          "Drop your file here or click here to upload\nYou can upload up to 5 files",
                                    ),
                                  ),
                            const Text("500x500",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),

                        const SizedBox(height: 20),
                        CustomButton(
                          onTap: () {
                            // Handle form submission
                          },
                          buttonText: "Register",
                        ),
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
