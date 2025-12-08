import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchableDropdown extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onChanged;
  final bool isMultiSelect;
  final String hint;
  final Color borderColor;

  const CustomSearchableDropdown({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.isMultiSelect = false,
    this.hint = "Select State",
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  State<CustomSearchableDropdown> createState() =>
      _CustomSearchableDropdownState();
}

class _CustomSearchableDropdownState extends State<CustomSearchableDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  bool isOpen = false;
  String search = "";
  late List<String> tempSelected;

  @override
  void initState() {
    super.initState();
    tempSelected = List.from(widget.selectedItems);
  }

  void toggleDropdown() {
    if (isOpen) {
      closeDropdown();
    } else {
      openDropdown();
    }
  }

  void openDropdown() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => isOpen = true);
  }

  void closeDropdown() {
    _overlayEntry?.remove();
    setState(() => isOpen = false);
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    // Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 6.h),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(10.w),
                constraints: BoxConstraints(
                  maxHeight: 280.h,
                ),
                child: Column(
                  children: [
                    /// SEARCH BAR
                    SizedBox(
                      height: 48.h,
                      child: TextField(
                          cursorColor: AppColors.black,
                          onChanged: (value) {
                            setState(() => search = value);
                            _overlayEntry?.markNeedsBuild();
                          },
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 12.w),

                            hintText: "Search...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14.sp,
                            ),

                            prefixIcon: Icon(
                              Icons.search,
                              size: 18.sp,
                              color: Colors.grey.shade700,
                            ),

                            filled: true,
                            fillColor:
                                Colors.grey.shade200, // light grey background

                            // REMOVE BORDERS COMPLETELY
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          )),
                    ), // If you need fixed height

                    SizedBox(height: 10.h),

                    /// LIST
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: widget.items
                            .where((e) =>
                                e.toLowerCase().contains(search.toLowerCase()))
                            .map((item) {
                          bool isChecked = tempSelected.contains(item);

                          return InkWell(
                            onTap: () {
                              if (widget.isMultiSelect) {
                                setState(() {
                                  isChecked
                                      ? tempSelected.remove(item)
                                      : tempSelected.add(item);
                                });
                                widget.onChanged(tempSelected);
                                _overlayEntry?.markNeedsBuild();
                              } else {
                                widget.onChanged([item]);
                                closeDropdown();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 4.w),
                              child: Row(
                                children: [
                                  if (widget.isMultiSelect)
                                    Checkbox(
                                      value: isChecked,
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          value == true
                                              ? tempSelected.add(item)
                                              : tempSelected.remove(item);
                                        });
                                        widget.onChanged(tempSelected);
                                        _overlayEntry?.markNeedsBuild();
                                      },
                                    ),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayText = widget.selectedItems.isEmpty
        ? widget.hint
        : widget.isMultiSelect
            ? widget.selectedItems.join(", ")
            : widget.selectedItems.first;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: widget.borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayText,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: widget.selectedItems.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
              ),
              Icon(
                isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
