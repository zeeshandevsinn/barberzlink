import 'dart:io';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_button.dart';
import 'package:barberzlink/widgets/custom_textfield.dart';
import 'package:barberzlink/widgets/dotted_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EventRegisterScreen extends StatefulWidget {
  const EventRegisterScreen({super.key});

  @override
  State<EventRegisterScreen> createState() => _EventRegisterScreenState();
}

class _EventRegisterScreenState extends State<EventRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _hostNameController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _selectDate({required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime({required bool isStart}) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(title: "Event Registration", isBack: true),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Name of the Event',
                    icon: Icons.event,
                    controller: _eventNameController,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    label: 'Host Name',
                    icon: Icons.person_outline,
                    controller: _hostNameController,
                  ),
                  const SizedBox(height: 18),

                  // Start Date and Time
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _selectDate(isStart: true),
                          icon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.black,
                          ),
                          label: Text(
                            _startDate == null
                                ? 'Start Date'
                                : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                            style: const TextStyle(color: Colors.black87),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _selectTime(isStart: true),
                          icon: const Icon(Icons.access_time,
                              color: AppColors.black),
                          label: Text(
                            _startTime == null
                                ? 'Start Time'
                                : _startTime!.format(context),
                            style: const TextStyle(color: Colors.black87),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // End Date and Time
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _selectDate(isStart: false),
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.black,
                          ),
                          label: Text(
                            _endDate == null
                                ? 'End Date'
                                : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                            style: const TextStyle(color: Colors.black87),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _selectTime(isStart: false),
                          icon: const Icon(
                            Icons.access_time_filled,
                            color: AppColors.black,
                          ),
                          label: Text(
                            _endTime == null
                                ? 'End Time'
                                : _endTime!.format(context),
                            style: const TextStyle(color: Colors.black87),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Image Upload
                  GestureDetector(
                    onTap: _pickImage,
                    child: _imageFile == null
                        ? DottedBorderContainer(
                            text:
                                'Tap to upload event photo\n(Maximum 1 photo)',
                          )
                        : Container(
                            height: 160,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),

                  // Register Button

                  CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (_imageFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please upload at least one photo.'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }

                          AppRoutes.goTo(context, AppRoutes.event_payment);
                          // TODO: Add backend logic to save event data
                        }
                      },
                      buttonText: 'Register Event'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
