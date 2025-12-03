import 'dart:io';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/view/main/profile/widgets/barber_profile_form.dart';
import 'package:barberzlink/view/main/profile/widgets/event_profile_form.dart';
import 'package:barberzlink/view/main/profile/widgets/school_profile_form.dart';
import 'package:barberzlink/view/main/profile/widgets/shop_profile_form.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/theme/app_theme.dart';

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
        appBar: kIsWeb
            ? AppBar(
                title: Text(
                  "Edit Profile",
                  style: AppTextStyle.semiBold(),
                ),
                centerTitle: true,
                elevation: 1,
              )
            : PreferredSize(
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
    return BarberProfileForm(
      formKey: _barberFormKey,
      controllers: _barberControllers,
      profileImage: _barberProfileImage,
      galleryImages: _barberGallery,
      onSave: () => _saveForm(_barberFormKey, 'Barber profile updated'),
      onPickProfileImage: () => _pickSingleImage(_ProfileType.barber),
      onPickGalleryImages: () => _pickGalleryImages(_ProfileType.barber),
    );
  }

  Widget _buildBarberShopForm() {
    return ShopProfileForm(
      formKey: _shopFormKey,
      controllers: _shopControllers,
      mainImage: _shopMainImage,
      galleryImages: _shopGallery,
      services: _shopServices,
      selectedState: _selectedShopState,
      states: _states,
      onSave: () => _saveForm(_shopFormKey, 'Barbershop profile updated'),
      onPickMainImage: () => _pickSingleImage(_ProfileType.shop),
      onPickGalleryImages: () => _pickGalleryImages(_ProfileType.shop),
      onStateChanged: (value) {
        if (value != null) setState(() => _selectedShopState = value);
      },
      onServiceToggle: (service) {
        setState(
            () => _shopServices[service] = !(_shopServices[service] ?? false));
      },
    );
  }

  Widget _buildSchoolForm() {
    return SchoolProfileForm(
      formKey: _schoolFormKey,
      controllers: _schoolControllers,
      mainImage: _schoolMainImage,
      galleryImages: _schoolGallery,
      selectedState: _selectedSchoolState,
      states: _states,
      onSave: () => _saveForm(_schoolFormKey, 'School profile updated'),
      onPickMainImage: () => _pickSingleImage(_ProfileType.school),
      onPickGalleryImages: () => _pickGalleryImages(_ProfileType.school),
      onStateChanged: (value) {
        if (value != null) setState(() => _selectedSchoolState = value);
      },
    );
  }

  Widget _buildEventForm() {
    return EventProfileForm(
      formKey: _eventFormKey,
      controllers: _eventControllers,
      heroImage: _eventHeroImage,
      startDate: _eventStartDate,
      endDate: _eventEndDate,
      startTime: _eventStartTime,
      endTime: _eventEndTime,
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
      onPickHeroImage: () => _pickSingleImage(_ProfileType.event),
      onPickStartDate: () => _pickDate(true),
      onPickEndDate: () => _pickDate(false),
      onPickStartTime: () => _pickTime(true),
      onPickEndTime: () => _pickTime(false),
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
