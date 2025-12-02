import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStateDropdown extends StatelessWidget {
  final List<String> states;
  final String? selectedState;
  final ValueChanged<String?> onStateChanged;

  const CustomStateDropdown({
    Key? key,
    required this.states,
    required this.selectedState,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.black26),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedState,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.grey.shade600,
          ),
          dropdownColor: Colors.white,
          items: states
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
          onChanged: onStateChanged,
        ),
      ),
    );
  }
}
