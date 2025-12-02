import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/dotted_container.dart';
import '../../widgets/custom_app_bar.dart';
import '../../core/routes/app_routes.dart';

class BusinessTipsRegistration extends StatefulWidget {
  const BusinessTipsRegistration({super.key});

  @override
  State<BusinessTipsRegistration> createState() =>
      _BusinessTipsRegistrationState();
}

class _BusinessTipsRegistrationState extends State<BusinessTipsRegistration> {
  // --- Text Controllers ---
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _statesServedController = TextEditingController();
  final TextEditingController _servicesForBarbersController =
      TextEditingController();
  final TextEditingController _minimumRequirementsController =
      TextEditingController();
  final TextEditingController _mainProductsController = TextEditingController();
  final TextEditingController _specialOffersController =
      TextEditingController();
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _offerDatesController = TextEditingController();
  final TextEditingController _licensesController = TextEditingController();
  final TextEditingController _profileDescriptionController =
      TextEditingController();

  // --- Image/File ---
  File? _logoImage;
  final ImagePicker _picker = ImagePicker();
  List<File> _supportingDocuments = [];

  // --- Multi-select options ---
  List<String> typeOfBusinessOptions = [
    'Bank / Credit Union',
    'Business Lending',
    'Equipment Financing / Leasing',
    'Insurance (Liability / Property)',
    'Health / Life Insurance',
    'Investment / Retirement Planning',
    'Tax / Accounting Services',
    'Other'
  ];
  List<String> selectedBusinessTypes = [];

  List<String> idealClientOptions = [
    'Individual Barbers',
    'Barbershops / Salon Owners',
    'Multi-location Shops',
    'Students / New Barbers'
  ];
  List<String> selectedIdealClients = [];

  List<String> productOptions = [
    'Start-up business loans',
    'Expansion / remodel loans',
    'Equipment financing (chairs, tools, etc.)',
    'Business checking / savings accounts',
    'Credit cards / lines of credit',
    'General liability insurance',
    'Property / contents insurance',
    'Workers’ compensation insurance',
    'Health / life insurance plans',
    'Retirement plans (IRA, 401k, SEP, etc.)',
    'Tax & bookkeeping services',
    'Other'
  ];
  List<String> selectedProducts = [];

  List<String> displayOptions = [
    'Featured Partner',
    'Listed in Financial Services Directory',
    'Listed in Insurance & Protection',
    'Listed in Investment & Retirement'
  ];
  List<String> selectedDisplayOptions = [];

  bool isLicensed = false;
  bool consentGiven = false;

  // --- Pick Logo ---
  Future<void> _pickLogo() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) setState(() => _logoImage = File(picked.path));
    } else {
      openAppSettings();
    }
  }

  // --- Pick Supporting Documents ---
  Future<void> _pickDocuments() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final picked = await _picker.pickMultiImage();
      if (picked.isNotEmpty) {
        setState(() {
          _supportingDocuments.clear();
          _supportingDocuments.addAll(picked.map((e) => File(e.path)));
        });
      }
    } else {
      openAppSettings();
    }
  }

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

  Widget _buildMultiSelect(
      String title, List<String> options, List<String> selectedValues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(title, true),
        Wrap(
          spacing: 10,
          children: options.map((option) {
            final selected = selectedValues.contains(option);
            return FilterChip(
              label: Text(option),
              selected: selected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    selectedValues.add(option);
                  } else {
                    selectedValues.remove(option);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: 'Financial Partner Registration',
            isBack: true,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💰 Barberz Link – Financial / Insurance / Investment Partner Registration',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Fill the form below to register and offer services to barbers and barbershops nationwide.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // --- Business Information ---
              CustomTextField(
                controller: _businessNameController,
                label: "Business Name",
                isTitle: true,
                titleName: "Business Name",
              ),
              _buildMultiSelect("Type of Business", typeOfBusinessOptions,
                  selectedBusinessTypes),
              CustomTextField(
                controller: _websiteController,
                label: "Website",
                isTitle: true,
                titleName: "Website",
              ),
              CustomTextField(
                controller: _contactNameController,
                label: "Primary Contact Name",
                isTitle: true,
                titleName: "Primary Contact Name",
              ),
              CustomTextField(
                controller: _contactEmailController,
                label: "Contact Email",
                isTitle: true,
                titleName: "Contact Email",
              ),
              CustomTextField(
                controller: _contactPhoneController,
                label: "Contact Phone",
                isTitle: true,
                titleName: "Contact Phone",
              ),
              CustomTextField(
                controller: _businessAddressController,
                label: "Business Address",
                isTitle: true,
                titleName: "Business Address",
              ),
              CustomTextField(
                controller: _statesServedController,
                label: "States You Serve",
                isTitle: true,
                titleName: "States You Serve",
              ),

              const SizedBox(height: 20),
              // --- Services for Barbers ---
              CustomTextField(
                controller: _servicesForBarbersController,
                label: "Services for Barbers / Barbershops",
                isTitle: true,
                titleName: "Services for Barbers",
                maxLines: 3,
              ),
              _buildMultiSelect(
                  "Ideal Client", idealClientOptions, selectedIdealClients),
              CustomTextField(
                controller: _minimumRequirementsController,
                label: "Minimum Requirements",
                isTitle: true,
                titleName: "Minimum Requirements",
                maxLines: 2,
              ),

              const SizedBox(height: 20),
              // --- Financial / Insurance / Investment Products ---
              _buildMultiSelect("Types of Products Provided", productOptions,
                  selectedProducts),
              CustomTextField(
                controller: _mainProductsController,
                label: "Briefly describe your main product(s)",
                isTitle: true,
                titleName: "Main Products",
                maxLines: 3,
              ),

              const SizedBox(height: 20),
              // --- Special Offers ---
              _buildMultiSelect(
                "Do you offer special discounts or programs?",
                ["Yes", "No"],
                _specialOffersController.text.isEmpty
                    ? []
                    : [_specialOffersController.text],
              ),
              CustomTextField(
                controller: _specialOffersController,
                label: "If Yes, describe",
                isTitle: true,
                titleName: "Special Offers",
                maxLines: 2,
              ),
              CustomTextField(
                controller: _promoCodeController,
                label: "Promo Code / Offer Name",
                isTitle: true,
                titleName: "Promo Code",
              ),
              CustomTextField(
                controller: _offerDatesController,
                label: "Offer Start / End Dates",
                isTitle: true,
                titleName: "Offer Dates",
              ),

              const SizedBox(height: 20),
              // --- Licensing & Credentials ---
              Row(
                children: [
                  Checkbox(
                    value: isLicensed,
                    onChanged: (val) {
                      setState(() => isLicensed = val!);
                    },
                  ),
                  const Expanded(
                      child: Text(
                          "Are you properly licensed/registered for the services you provide?")),
                ],
              ),
              CustomTextField(
                controller: _licensesController,
                label:
                    "List any licenses, registrations, or certifications (state/number)",
                isTitle: true,
                titleName: "Licenses",
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Upload Supporting Documents", false),
                  _supportingDocuments.isNotEmpty
                      ? Wrap(
                          spacing: 8,
                          children: _supportingDocuments
                              .map((file) => Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.file(file, fit: BoxFit.cover),
                                  ))
                              .toList(),
                        )
                      : GestureDetector(
                          onTap: _pickDocuments,
                          child: DottedBorderContainer(
                            text:
                                "Drop files here or click to upload\nMax 5 files",
                          ),
                        ),
                ],
              ),

              const SizedBox(height: 20),
              // --- Marketing & Display ---
              _buildMultiSelect("How would you like to appear in Barberz Link?",
                  displayOptions, selectedDisplayOptions),
              CustomTextField(
                controller: _profileDescriptionController,
                label: "Short description (max 250 chars)",
                isTitle: true,
                titleName: "Profile Description",
                maxLines: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Logo Upload", false),
                  _logoImage != null
                      ? Container(
                          height: 160,
                          width: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_logoImage!, fit: BoxFit.cover),
                          ),
                        )
                      : GestureDetector(
                          onTap: _pickLogo,
                          child: DottedBorderContainer(
                            text:
                                "Drop your logo here or click to upload\nMax 1 file",
                          ),
                        ),
                ],
              ),

              const SizedBox(height: 20),
              // --- Consent ---
              Row(
                children: [
                  Checkbox(
                      value: consentGiven,
                      onChanged: (val) {
                        setState(() => consentGiven = val!);
                      }),
                  const Expanded(
                      child: Text(
                          "I confirm that the information provided is accurate and I am authorized to submit this on behalf of the business.")),
                ],
              ),

              const SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  // Handle submission
                  AppRoutes.goTo(context, AppRoutes.barber_payment);
                },
                buttonText: "Submit",
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
