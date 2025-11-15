import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class KeywordSearchBar extends StatelessWidget {
  final TextEditingController keywordController;
  final String selectedState;
  final List<String> states;
  final Function(String?) onStateChanged;
  final VoidCallback onSearch;

  const KeywordSearchBar({
    super.key,
    required this.keywordController,
    required this.selectedState,
    required this.states,
    required this.onStateChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Keyword (Optional)"),
          SizedBox(height: 6.h),
          _buildTextField("Keyword...", keywordController),
          SizedBox(height: 12.h),
          _buildLabel("State (Optional)"),
          SizedBox(height: 6.h),
          AnimatedContainer(
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
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: onSearch,
              child: Text(
                "SEARCH",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Label builder
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
    );
  }

  /// Text field builder
  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey.shade500,
          fontSize: 13.sp,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
