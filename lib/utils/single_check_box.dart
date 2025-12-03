import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleSelectCheckbox extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String? selected;

  const SingleSelectCheckbox({
    Key? key,
    required this.options,
    required this.onChanged,
    this.selected,
  }) : super(key: key);

  @override
  State<SingleSelectCheckbox> createState() => _SingleSelectCheckboxState();
}

class _SingleSelectCheckboxState extends State<SingleSelectCheckbox> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        bool isSelected = selectedValue == option;

        return GestureDetector(
          onTap: () {
            setState(() => selectedValue = option);
            widget.onChanged(option);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey,
                      width: 1.5,
                    ),
                    color: isSelected ? Colors.black : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.sp,
                        )
                      : null,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
