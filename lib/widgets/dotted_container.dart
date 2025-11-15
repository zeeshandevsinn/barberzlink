import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

class DottedBorderContainer extends StatelessWidget {
  final String text;

  const DottedBorderContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      child: Container(
        height: 180,
        width: double.infinity,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.cloud_upload,
                size: 40,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
