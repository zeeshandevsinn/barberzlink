import 'dart:io';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/custom_textfield.dart';

class BarberShopRegistrationScreen extends StatefulWidget {
  const BarberShopRegistrationScreen({super.key});

  @override
  State<BarberShopRegistrationScreen> createState() =>
      _BarberShopRegistrationScreenState();
}

class _BarberShopRegistrationScreenState
    extends State<BarberShopRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _shopName = TextEditingController();
  final TextEditingController _fullAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _website = TextEditingController();
  final TextEditingController _instagram = TextEditingController();

  // Dropdown values
  String _selectedState = "All States";

  // Checkboxes
  final List<String> _services = [
    'Haircut',
    'Beard Trim',
    'Hair Coloring',
    'Shaving',
    'Facial',
    'Massage'
  ];
  final Map<String, bool> _selectedServices = {};
  bool _selectAll = false;

  // Radio buttons
  String? _multiLocation = 'No';

  // Image pickers
  File? _mainImage;
  final List<File> _galleryImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMainImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _mainImage = File(picked.path));
  }

  Future<void> _pickGalleryImages() async {
    final picked = await _picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        _galleryImages.clear();
        _galleryImages.addAll(picked.take(5).map((e) => File(e.path)));
      });
    }
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      for (var service in _services) {
        _selectedServices[service] = _selectAll;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    for (var service in _services) {
      _selectedServices[service] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              title: "BarberShop Registration",
              isBack: true,
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/images/barberz_logo.png',
                  height: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  'BarberShop Registration',
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
                const SizedBox(height: 30),

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
                  obscure: true,
                ),
                const SizedBox(height: 18),

                // Shop Info
                CustomTextField(
                  isTitle: true,
                  titleName: 'Barbershop Name',
                  label: 'Barbershop Name',
                  icon: Icons.storefront_outlined,
                  controller: _shopName,
                ),
                const SizedBox(height: 18),
                CustomTextField(
                  isTitle: true,
                  titleName: 'Barbershop Full Address',
                  label: 'Barbershop Full Address',
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
                CustomTextField(
                  isTitle: true,
                  titleName: 'Instagram',
                  label: 'Instagram',
                  icon: Icons.camera_alt_outlined,
                  controller: _instagram,
                ),
                const SizedBox(height: 30),

                // Popular Services
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Popular Services:',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CheckboxListTile(
                  title: Text('Select All', style: AppTextStyle.medium()),
                  value: _selectAll,
                  activeColor: Colors.amber[800],
                  onChanged: _toggleSelectAll,
                ),
                ..._services.map((service) {
                  return CheckboxListTile(
                    title: Text(service, style: AppTextStyle.medium()),
                    value: _selectedServices[service],
                    activeColor: Colors.amber[800],
                    onChanged: (value) {
                      setState(() {
                        _selectedServices[service] = value!;
                        _selectAll = _selectedServices.values
                            .every((selected) => selected);
                      });
                    },
                  );
                }),
                const SizedBox(height: 30),

                // Main Image
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Shop Main Image',
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
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.2,
                      ),
                    ),
                    child: _mainImage == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.cloud_upload_outlined,
                                    color: Colors.black54, size: 30),
                                SizedBox(height: 8),
                                Text('Drop your file here or click to upload'),
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_mainImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity),
                          ),
                  ),
                ),
                const SizedBox(height: 30),

                // Gallery Images
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Shop Images (Up to 5)',
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
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black26, width: 1.2),
                    ),
                    child: _galleryImages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.photo_library_outlined,
                                    color: Colors.black54, size: 30),
                                SizedBox(height: 8),
                                Text('Drop your files here or click to upload'),
                              ],
                            ),
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _galleryImages
                                .map((file) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(file,
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover),
                                    ))
                                .toList(),
                          ),
                  ),
                ),
                const SizedBox(height: 30),

                // Multiple locations
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Do you have multiple locations?',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          'Yes',
                          style: AppTextStyle.medium(),
                        ),
                        value: 'Yes',
                        groupValue: _multiLocation,
                        activeColor: Colors.amber[800],
                        onChanged: (value) {
                          setState(() => _multiLocation = value);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          'No',
                          style: AppTextStyle.medium(),
                        ),
                        value: 'No',
                        groupValue: _multiLocation,
                        activeColor: Colors.amber[800],
                        onChanged: (value) {
                          setState(() => _multiLocation = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('BarberShop Registered Successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
