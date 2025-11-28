import 'dart:io';

import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/core/theme/app_theme.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/custom_textfield.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum _ProfileType { barber, shop, school, event }

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _barberFormKey = GlobalKey<FormState>();
  final _shopFormKey = GlobalKey<FormState>();
  final _schoolFormKey = GlobalKey<FormState>();
  final _eventFormKey = GlobalKey<FormState>();

  late final Map<String, TextEditingController> _barberControllers;
  late final Map<String, TextEditingController> _shopControllers;
  late final Map<String, TextEditingController> _schoolControllers;
  late final Map<String, TextEditingController> _eventControllers;

  final ImagePicker _picker = ImagePicker();
  final List<String> _states = Injections.instance.states;
  final Map<String, bool> _shopServices = {
    'Haircut': true,
    'Beard Trim': true,
    'Hot Towel': false,
    'Hair Color': false,
    'Kids Cut': true,
    'Facial': false,
  };

  File? _barberProfileImage;
  List<File> _barberGallery = [];
  File? _shopMainImage;
  List<File> _shopGallery = [];
  File? _schoolMainImage;
  List<File> _schoolGallery = [];
  File? _eventHeroImage;

  String _selectedShopState = 'CA';
  String _selectedSchoolState = 'NY';
  DateTime? _eventStartDate = DateTime.now();
  DateTime? _eventEndDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay? _eventStartTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay? _eventEndTime = const TimeOfDay(hour: 14, minute: 0);

  @override
  void initState() {
    super.initState();
    _barberControllers = {
      'firstName': TextEditingController(text: 'Marcus'),
      'lastName': TextEditingController(text: 'Fadez'),
      'username': TextEditingController(text: 'marcus.fadez'),
      'password': TextEditingController(text: 'StrongPass!23'),
      'fullName': TextEditingController(text: 'Marcus Fadez'),
      'email': TextEditingController(text: 'marcus@fadezstudio.com'),
      'phone': TextEditingController(text: '+1 323 444 9876'),
      'address': TextEditingController(
          text: '225 Liberty St Unit 222, New York, NY 10080'),
      'website': TextEditingController(text: 'https://fadezstudio.com'),
      'instagram': TextEditingController(text: '@marcusfadez'),
      'bio': TextEditingController(
          text:
              'Award winning barber working across NYC and LA. Specialising in modern fades, beard sculpting, and on-set grooming.'),
    };

    _shopControllers = {
      'contactFirst': TextEditingController(text: 'Lena'),
      'contactLast': TextEditingController(text: 'Sharp'),
      'email': TextEditingController(text: 'hello@thefadefactory.com'),
      'username': TextEditingController(text: 'fade_factory'),
      'shopName': TextEditingController(text: 'The Fade Factory'),
      'address': TextEditingController(text: '527 W 7th St'),
      'city': TextEditingController(text: 'Los Angeles'),
      'about': TextEditingController(
          text:
              'Boutique grooming studio mixing hospitality with editorial-level cuts.'),
      'phone': TextEditingController(text: '+1 213 555 1299'),
      'website': TextEditingController(text: 'https://thefadefactory.com'),
      'instagram': TextEditingController(text: '@thefadefactoryla'),
    };

    _schoolControllers = {
      'firstName': TextEditingController(text: 'Devon'),
      'lastName': TextEditingController(text: 'Cole'),
      'email': TextEditingController(text: 'contact@modernmanacademy.com'),
      'username': TextEditingController(text: 'modernmanacademy'),
      'password': TextEditingController(text: 'SecurePass@001'),
      'schoolName': TextEditingController(text: 'Modern Man Academy'),
      'address': TextEditingController(text: '190 N State St'),
      'city': TextEditingController(text: 'Chicago'),
      'about': TextEditingController(
          text:
              'National academy placing 300+ graduates per quarter with elite barbershops and studios.'),
      'phone': TextEditingController(text: '+1 773 555 8700'),
      'website': TextEditingController(text: 'https://modernmanacademy.com'),
      'instagram': TextEditingController(text: '@modernmanacademy'),
    };

    _eventControllers = {
      'eventName': TextEditingController(text: 'Legends Barber Summit'),
      'hostName': TextEditingController(text: 'Barberz Link'),
      'location': TextEditingController(
          text: 'Miami Convention Center, 400 SE 2nd Ave, Miami, FL'),
      'website': TextEditingController(text: 'https://barberzlink.com/events'),
      'instagram': TextEditingController(text: '@barberzlink'),
    };
  }

  @override
  void dispose() {
    for (final controller in [
      ..._barberControllers.values,
      ..._shopControllers.values,
      ..._schoolControllers.values,
      ..._eventControllers.values,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            title: 'Edit Profile',
            isBack: true,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  splashBorderRadius: BorderRadius.circular(40),
                  tabs: const [
                    Tab(text: 'Barber'),
                    Tab(text: 'Barbershop'),
                    Tab(text: 'Schools'),
                    Tab(text: 'Events'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBarberForm(),
                  _buildBarberShopForm(),
                  _buildSchoolForm(),
                  _buildEventForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarberForm() {
    final fields = [
      _FieldConfig(
        controller: _barberControllers['firstName']!,
        label: 'First Name',
        icon: Icons.person,
      ),
      _FieldConfig(
        controller: _barberControllers['lastName']!,
        label: 'Last Name',
        icon: Icons.person_outline,
      ),
      _FieldConfig(
        controller: _barberControllers['username']!,
        label: 'Username',
        icon: Icons.alternate_email,
      ),
      _FieldConfig(
        controller: _barberControllers['password']!,
        label: 'User Password',
        icon: Icons.lock_outline,
        isPassword: true,
      ),
      _FieldConfig(
        controller: _barberControllers['fullName']!,
        label: 'Brand / Display Name',
        icon: Icons.badge_outlined,
      ),
      _FieldConfig(
        controller: _barberControllers['email']!,
        label: 'Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      _FieldConfig(
        controller: _barberControllers['phone']!,
        label: 'Phone',
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
      ),
      _FieldConfig(
        controller: _barberControllers['address']!,
        label: 'Full Address',
        icon: Icons.location_on_outlined,
      ),
      _FieldConfig(
        controller: _barberControllers['website']!,
        label: 'Website Link',
        icon: Icons.language,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      _FieldConfig(
        controller: _barberControllers['instagram']!,
        label: 'Instagram Username',
        icon: Icons.camera_alt_outlined,
      ),
      _FieldConfig(
        controller: _barberControllers['bio']!,
        label: 'About Your Craft',
        icon: Icons.description_outlined,
        maxLines: 4,
      ),
    ];

    return _buildFormShell(
      formKey: _barberFormKey,
      fields: fields,
      extraChildren: [
        _buildImageSection(
          title: 'Profile Picture',
          helper: '500x500 recommended · Tap to update',
          file: _barberProfileImage,
          onTap: () => _pickSingleImage(_ProfileType.barber),
        ),
        const SizedBox(height: 18),
        _buildGallerySection(
          title: 'Featured Work (up to 5)',
          helper: 'Showcase your best fades, beard work, or styles.',
          files: _barberGallery,
          onTap: () => _pickGalleryImages(_ProfileType.barber),
        ),
      ],
      onSave: () => _saveForm(_barberFormKey, 'Barber profile updated'),
    );
  }

  Widget _buildBarberShopForm() {
    final fields = [
      _FieldConfig(
        controller: _shopControllers['contactFirst']!,
        label: 'Contact First Name',
        icon: Icons.person,
      ),
      _FieldConfig(
        controller: _shopControllers['contactLast']!,
        label: 'Contact Last Name',
        icon: Icons.person_outline,
      ),
      _FieldConfig(
        controller: _shopControllers['email']!,
        label: 'User Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      _FieldConfig(
        controller: _shopControllers['username']!,
        label: 'Username',
        icon: Icons.account_circle_outlined,
      ),
      _FieldConfig(
        controller: _shopControllers['shopName']!,
        label: 'Barbershop Name',
        icon: Icons.storefront_outlined,
      ),
      _FieldConfig(
        controller: _shopControllers['address']!,
        label: 'Full Address',
        icon: Icons.location_on_outlined,
      ),
      _FieldConfig(
        controller: _shopControllers['city']!,
        label: 'City',
        icon: Icons.location_city,
      ),
      _FieldConfig(
        controller: _shopControllers['about']!,
        label: 'About the Shop',
        icon: Icons.notes_outlined,
        maxLines: 4,
      ),
      _FieldConfig(
        controller: _shopControllers['phone']!,
        label: 'Phone',
        icon: Icons.phone,
        keyboardType: TextInputType.phone,
      ),
      _FieldConfig(
        controller: _shopControllers['website']!,
        label: 'Website',
        icon: Icons.language,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      _FieldConfig(
        controller: _shopControllers['instagram']!,
        label: 'Instagram',
        icon: Icons.camera_alt_outlined,
        isRequired: false,
      ),
    ];

    return _buildFormShell(
      formKey: _shopFormKey,
      fields: fields,
      extraChildren: [
        _buildStateDropdown(
          title: 'State',
          value: _selectedShopState,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedShopState = value);
          },
        ),
        const SizedBox(height: 18),
        _buildServicesChips(),
        const SizedBox(height: 18),
        _buildImageSection(
          title: 'Shop Main Image',
          helper: 'Tap to replace your hero image.',
          file: _shopMainImage,
          onTap: () => _pickSingleImage(_ProfileType.shop),
        ),
        const SizedBox(height: 18),
        _buildGallerySection(
          title: 'Shop Gallery (up to 5)',
          files: _shopGallery,
          onTap: () => _pickGalleryImages(_ProfileType.shop),
        ),
      ],
      onSave: () => _saveForm(_shopFormKey, 'Barbershop profile updated'),
    );
  }

  Widget _buildSchoolForm() {
    final fields = [
      _FieldConfig(
        controller: _schoolControllers['firstName']!,
        label: 'Contact First Name',
        icon: Icons.person,
      ),
      _FieldConfig(
        controller: _schoolControllers['lastName']!,
        label: 'Contact Last Name',
        icon: Icons.person_outline,
      ),
      _FieldConfig(
        controller: _schoolControllers['email']!,
        label: 'User Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
      ),
      _FieldConfig(
        controller: _schoolControllers['username']!,
        label: 'Username',
        icon: Icons.account_circle_outlined,
      ),
      _FieldConfig(
        controller: _schoolControllers['password']!,
        label: 'Password',
        icon: Icons.lock_outline,
        isPassword: true,
      ),
      _FieldConfig(
        controller: _schoolControllers['schoolName']!,
        label: 'School Name',
        icon: Icons.school_outlined,
      ),
      _FieldConfig(
        controller: _schoolControllers['address']!,
        label: 'Full Address',
        icon: Icons.location_on_outlined,
      ),
      _FieldConfig(
        controller: _schoolControllers['city']!,
        label: 'City',
        icon: Icons.location_city,
      ),
      _FieldConfig(
        controller: _schoolControllers['about']!,
        label: 'About the School',
        icon: Icons.notes_outlined,
        maxLines: 4,
      ),
      _FieldConfig(
        controller: _schoolControllers['phone']!,
        label: 'Phone',
        icon: Icons.phone,
        keyboardType: TextInputType.phone,
      ),
      _FieldConfig(
        controller: _schoolControllers['website']!,
        label: 'Website',
        icon: Icons.language,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      _FieldConfig(
        controller: _schoolControllers['instagram']!,
        label: 'Instagram',
        icon: Icons.camera_alt_outlined,
        isRequired: false,
      ),
    ];

    return _buildFormShell(
      formKey: _schoolFormKey,
      fields: fields,
      extraChildren: [
        _buildStateDropdown(
          title: 'State',
          value: _selectedSchoolState,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedSchoolState = value);
          },
        ),
        const SizedBox(height: 18),
        _buildImageSection(
          title: 'Campus Main Image',
          helper: 'Recommended 1200x600 hero image.',
          file: _schoolMainImage,
          onTap: () => _pickSingleImage(_ProfileType.school),
        ),
        const SizedBox(height: 18),
        _buildGallerySection(
          title: 'Campus Gallery (up to 5)',
          files: _schoolGallery,
          onTap: () => _pickGalleryImages(_ProfileType.school),
        ),
      ],
      onSave: () => _saveForm(_schoolFormKey, 'School profile updated'),
    );
  }

  Widget _buildEventForm() {
    final fields = [
      _FieldConfig(
        controller: _eventControllers['eventName']!,
        label: 'Event Name',
        icon: Icons.event_outlined,
      ),
      _FieldConfig(
        controller: _eventControllers['hostName']!,
        label: 'Host Name',
        icon: Icons.person,
      ),
      _FieldConfig(
        controller: _eventControllers['location']!,
        label: 'Location',
        icon: Icons.location_on_outlined,
        maxLines: 2,
      ),
      _FieldConfig(
        controller: _eventControllers['website']!,
        label: 'Website / Tickets Link',
        icon: Icons.link,
        keyboardType: TextInputType.url,
        isRequired: false,
      ),
      _FieldConfig(
        controller: _eventControllers['instagram']!,
        label: 'Instagram Handle',
        icon: Icons.camera_alt_outlined,
        isRequired: false,
      ),
    ];

    return _buildFormShell(
      formKey: _eventFormKey,
      fields: fields,
      extraChildren: [
        _buildDateTimeRow(
          label: 'Start',
          date: _eventStartDate,
          time: _eventStartTime,
          onDateTap: () => _pickDate(true),
          onTimeTap: () => _pickTime(true),
        ),
        const SizedBox(height: 12),
        _buildDateTimeRow(
          label: 'End',
          date: _eventEndDate,
          time: _eventEndTime,
          onDateTap: () => _pickDate(false),
          onTimeTap: () => _pickTime(false),
        ),
        const SizedBox(height: 18),
        _buildImageSection(
          title: 'Event Hero Image',
          helper: 'Tap to refresh flyers or hero artwork.',
          file: _eventHeroImage,
          onTap: () => _pickSingleImage(_ProfileType.event),
        ),
      ],
      onSave: () {
        if (_eventStartDate == null ||
            _eventEndDate == null ||
            _eventStartTime == null ||
            _eventEndTime == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please provide start and end date/time.'),
            ),
          );
          return;
        }
        _saveForm(_eventFormKey, 'Event profile updated');
      },
    );
  }

  Widget _buildFormShell({
    required GlobalKey<FormState> formKey,
    required List<_FieldConfig> fields,
    required VoidCallback onSave,
    List<Widget> extraChildren = const [],
  }) {
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
                  validator:
                      field.isRequired ? null : (value) => null, // optional
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

  Widget _buildImageSection({
    required String title,
    required File? file,
    required VoidCallback onTap,
    String helper = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: file == null
              ? const DottedBorderContainer(
                  text: 'Drop or tap to upload',
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    file,
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
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGallerySection({
    required String title,
    required List<File> files,
    required VoidCallback onTap,
    String helper = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: files.isEmpty
              ? const DottedBorderContainer(
                  text: 'Tap to upload gallery items',
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: files
                      .map(
                        (file) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file,
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
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildServicesChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Popular Services'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _shopServices.keys.map((service) {
            final selected = _shopServices[service] ?? false;
            return FilterChip(
              label: Text(service),
              selected: selected,
              onSelected: (value) {
                setState(() => _shopServices[service] = value);
              },
              checkmarkColor: Colors.white,
              selectedColor: AppColors.black,
              backgroundColor: Colors.grey.shade200,
              labelStyle: TextStyle(
                color: selected ? Colors.white : Colors.black87,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStateDropdown({
    required String title,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
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
              value: value,
              isExpanded: true,
              items: _states
                  .map(
                    (state) => DropdownMenuItem(
                      value: state,
                      child: Text(
                        state,
                        style: AppTextStyle.medium(),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeRow({
    required String label,
    required DateTime? date,
    required TimeOfDay? time,
    required VoidCallback onDateTap,
    required VoidCallback onTimeTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('$label Date & Time'),
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

  Text _buildSectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyle.semiBold(fontSize: 14),
    );
  }

  Future<void> _saveForm(
      GlobalKey<FormState> key, String successMessage) async {
    if (key.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(successMessage)),
      );
    }
  }

  Future<void> _pickSingleImage(_ProfileType type) async {
    if (!await _ensureGalleryPermission()) return;
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() {
      final file = File(picked.path);
      switch (type) {
        case _ProfileType.barber:
          _barberProfileImage = file;
          break;
        case _ProfileType.shop:
          _shopMainImage = file;
          break;
        case _ProfileType.school:
          _schoolMainImage = file;
          break;
        case _ProfileType.event:
          _eventHeroImage = file;
          break;
      }
    });
  }

  Future<void> _pickGalleryImages(_ProfileType type) async {
    if (!await _ensureGalleryPermission()) return;
    final picked = await _picker.pickMultiImage();
    if (picked.isEmpty) return;
    setState(() {
      final files = picked.take(5).map((e) => File(e.path)).toList();
      switch (type) {
        case _ProfileType.barber:
          _barberGallery = files;
          break;
        case _ProfileType.shop:
          _shopGallery = files;
          break;
        case _ProfileType.school:
          _schoolGallery = files;
          break;
        case _ProfileType.event:
          // events only use single hero image
          break;
      }
    });
  }

  Future<void> _pickDate(bool isStart) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: (isStart ? _eventStartDate : _eventEndDate) ??
          DateTime.now().add(Duration(days: isStart ? 0 : 1)),
      firstDate: DateTime(2023),
      lastDate: DateTime(2032),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _eventStartDate = pickedDate;
        } else {
          _eventEndDate = pickedDate;
        }
      });
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime:
          (isStart ? _eventStartTime : _eventEndTime) ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _eventStartTime = pickedTime;
        } else {
          _eventEndTime = pickedTime;
        }
      });
    }
  }

  Future<bool> _ensureGalleryPermission() async {
    if (kIsWeb) return true;
    final status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please grant photo permission to pick images.'),
      ),
    );
    openAppSettings();
    return false;
  }
}

class _FieldConfig {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isPassword;
  final bool isRequired;

  const _FieldConfig({
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.isPassword = false,
    this.isRequired = true,
  });
}

