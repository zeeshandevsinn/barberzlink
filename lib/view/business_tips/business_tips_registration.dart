import 'dart:io';
import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/utils/single_check_box.dart';
import 'package:barberzlink/widgets/custom_state_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// Custom Widgets
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/dotted_container.dart';
import '../../core/routes/app_routes.dart';

class BusinessTipsRegistrationScreen extends StatefulWidget {
  const BusinessTipsRegistrationScreen({super.key});

  @override
  State<BusinessTipsRegistrationScreen> createState() =>
      _BusinessTipsRegistrationScreenState();
}

class _BusinessTipsRegistrationScreenState
    extends State<BusinessTipsRegistrationScreen> {
  // ---------------- Controllers -------------------
  final TextEditingController businessNameCtrl = TextEditingController();
  final TextEditingController websiteCtrl = TextEditingController();
  final TextEditingController contactNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController mainProductsCtrl = TextEditingController();
  final TextEditingController specialOffersCtrl = TextEditingController();
  final TextEditingController promoCtrl = TextEditingController();
  final TextEditingController offerDatesCtrl = TextEditingController();
  final TextEditingController licenseCtrl = TextEditingController();
  final TextEditingController profileDescriptionCtrl = TextEditingController();

  List<String> selectedStateServed = [];

  List<String> minimumRequirements = [
    'Good credit score',
    'Minimum annual revenue',
    'Business plan submission',
    'Proof of business registration',
    'Other'
  ];

  List<String> servicesOfferedFor = ["Barbers", "Barbershops"];
  List<String> discountOff = ["Yes", "No"];
  String selectedServiceOfferedFor = "";
  String selectedDiscountOff = "No";
  // ------------------ Lists -----------------------
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

  List<String> idealClients = [
    'Individual Barbers',
    'Barbershops / Salon Owners',
    'Multi-location Shops',
    'Students / New Barbers'
  ];
  List<String> selectedClients = [];

  List<String> productsOptions = [
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
  List<String> selectedDisplay = [];

  // ------------- Uploading -------------------
  File? logo;
  List<File> documents = [];
  final picker = ImagePicker();

  Future<void> pickLogo() async {
    var permission = await Permission.photos.request();
    if (!permission.isGranted) return;

    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => logo = File(picked.path));
  }

  Future<void> pickDocuments() async {
    var permission = await Permission.photos.request();
    if (!permission.isGranted) return;

    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        documents.clear();
        documents.addAll(picked.map((e) => File(e.path)));
      });
    }
  }

  bool licensed = false;
  bool consentGiven = false;

  // ---------------- UI Helpers ----------------
  Widget buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildLabel(String label, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: label,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            if (required)
              const TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget multiSelect(
      String title, List<String> options, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildLabel(title, required: true),
          ],
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((item) {
            final selected = selectedList.contains(item);
            return FilterChip(
              label: Text(item),
              selected: selected,
              onSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedList.add(item);
                  } else {
                    selectedList.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ------------------ BUILD -------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("Financial Partner Registration"),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: CustomAppBar(
                  title: "Financial Partner Registration",
                  isBack: true,
                ),
              ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              AppStrings.businessTipsImage,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              "💰 Barberz Link – Financial / Insurance / Investment Partner Registration",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              AppStrings.businessTipsDescription,
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.black54, letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),

            // ------------------- 1️⃣ Business Information -------------------
            buildTitle("Business Information"),

            const SizedBox(height: 20),
            Column(
              spacing: 20,
              children: [
                CustomTextField(
                  controller: businessNameCtrl,
                  label: "Business Name",
                  isTitle: true,
                  titleName: "Business Name",
                  icon: Icons.business,
                ),
                multiSelect("Type of Business", typeOfBusinessOptions,
                    selectedBusinessTypes),
                CustomTextField(
                  controller: websiteCtrl,
                  label: "Website",
                  isTitle: true,
                  titleName: "Website",
                  icon: Icons.link,
                ),
                CustomTextField(
                  controller: contactNameCtrl,
                  label: "Contact Name",
                  isTitle: true,
                  titleName: "Contact Name",
                  icon: Icons.person,
                ),
                CustomTextField(
                  controller: emailCtrl,
                  label: "Contact Email",
                  isTitle: true,
                  titleName: "Contact Email",
                  icon: Icons.email,
                ),
                CustomTextField(
                  controller: phoneCtrl,
                  label: "Contact Phone",
                  isTitle: true,
                  titleName: "Contact Phone",
                  icon: Icons.phone,
                ),
                CustomTextField(
                  controller: addressCtrl,
                  label: "Business Address",
                  isTitle: true,
                  titleName: "Business Address",
                  icon: Icons.location_on,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("Select States Served",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                    CustomSearchableDropdown(
                        items: Injections.instance.states
                            .where((state) => state != 'All States')
                            .toList(),
                        selectedItems: selectedStateServed,
                        isMultiSelect: true,
                        onChanged: (newStates) {
                          setState(() {
                            selectedStateServed = newStates;
                          });
                        })
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Divider(),

            const SizedBox(height: 20),
            // ----------------- 2️⃣ Services for Barbers -----------------
            buildTitle("Services for Barbers & Barbershops"),

            const SizedBox(height: 20),
            Column(
              spacing: 20,
              children: [
                Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Which services do you offer specifically for?",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                    SingleSelectCheckbox(
                      options: servicesOfferedFor,
                      onChanged: (value) {
                        setState(() {
                          selectedServiceOfferedFor = value ?? '';
                        });
                      },
                      selected: selectedServiceOfferedFor,
                    ),
                  ],
                ),
                multiSelect("Ideal Client", idealClients, selectedClients),
                multiSelect("Minimum Requirements", minimumRequirements, []),
              ],
            ),

            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),

            // ----------------- 3️⃣ Products -----------------
            buildTitle("3️⃣ Financial / Insurance / Investment Products"),

            const SizedBox(height: 20),
            Column(
              spacing: 20,
              children: [
                multiSelect("Types of Products You Provide", productsOptions,
                    selectedProducts),
                CustomTextField(
                  controller: mainProductsCtrl,
                  label: "Describe main product(s)",
                  isTitle: true,
                  titleName: "Main Products",
                  maxLines: 3,
                ),
              ],
            ),

            const SizedBox(height: 20),
            Divider(),
            const SizedBox(
              height: 20,
            ),
            // ----------------- 4️⃣ Special Offers -----------------
            buildTitle("4️⃣ Special Offers for Barberz Link Users"),

            const SizedBox(height: 20),
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Do you offer special discounts?",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                SingleSelectCheckbox(
                  options: discountOff,
                  onChanged: (value) {
                    setState(() {
                      selectedDiscountOff = value ?? '';
                    });
                  },
                  selected: selectedServiceOfferedFor,
                ),
              ],
            ),
            if (selectedDiscountOff == "Yes") ...[
              Column(
                spacing: 20,
                children: [
                  CustomTextField(
                      controller: specialOffersCtrl,
                      label: "Describe the Special Offers",
                      isTitle: true,
                      titleName: "Special Offers",
                      maxLines: 2),
                  CustomTextField(
                      controller: promoCtrl,
                      label: "Promo Code / Offer Name",
                      isTitle: true,
                      titleName: "Promo Code"),
                  CustomTextField(
                      controller: offerDatesCtrl,
                      label: "Offer Start / End Dates",
                      isTitle: true,
                      titleName: "Offer Dates"),
                ],
              )
            ],

            const SizedBox(height: 20),
            Divider(),

            const SizedBox(height: 20),
            // ----------------- 5️⃣ Licensing -----------------
            buildTitle("5️⃣ Licensing & Credentials"),

            const SizedBox(height: 20),
            Column(
              spacing: 20,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: licensed,
                        onChanged: (val) => setState(() => licensed = val!)),
                    const Expanded(
                        child: Text(
                            "Are you properly licensed for your services?")),
                  ],
                ),
                CustomTextField(
                  controller: licenseCtrl,
                  label: "List your licenses / certifications",
                  isTitle: true,
                  titleName: "Licenses",
                  maxLines: 3,
                ),
                Column(
                  spacing: 5,
                  children: [
                    buildLabel("Upload Supporting Documents"),
                    documents.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            children: documents
                                .map((file) => Container(
                                      height: 80,
                                      width: 80,
                                      child:
                                          Image.file(file, fit: BoxFit.cover),
                                    ))
                                .toList(),
                          )
                        : GestureDetector(
                            onTap: pickDocuments,
                            child: DottedBorderContainer(
                                text: "Upload Supporting Documents\n(Max 5)"),
                          ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
            // ----------------- 6️⃣ Marketing -----------------
            buildTitle("6️⃣ Marketing & Display Preferences"),

            const SizedBox(height: 20),
            Column(
              spacing: 20,
              children: [
                multiSelect("How would you like to appear on Barberz Link?",
                    displayOptions, selectedDisplay),
                CustomTextField(
                  controller: profileDescriptionCtrl,
                  label: "Short profile description (max 250 chars)",
                  isTitle: true,
                  titleName: "Profile Description",
                  maxLines: 3,
                ),
                Column(
                  spacing: 5,
                  children: [
                    buildLabel("Logo Upload"),
                    logo != null
                        ? Container(
                            height: 160,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(logo!, fit: BoxFit.cover),
                            ),
                          )
                        : GestureDetector(
                            onTap: pickLogo,
                            child: DottedBorderContainer(
                                text: "Drop your logo here or click to upload"),
                          ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 20),
            Divider(),
            const SizedBox(
              height: 20,
            ),
            // ----------------- 7️⃣ Consent -----------------
            buildTitle("7️⃣ Consent"),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                    value: consentGiven,
                    activeColor: AppColors.black,
                    checkColor: AppColors.white,
                    onChanged: (val) => setState(() => consentGiven = val!)),
                const Expanded(
                    child: Text(
                        "I confirm that all information provided is accurate.")),
              ],
            ),

            const SizedBox(height: 24),

            // -------------------- SUBMIT --------------------
            CustomButton(
              buttonText: "Submit",
              onTap: () {
                AppRoutes.goTo(context, AppRoutes.business_payment);
              },
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
