// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class buildContactRow extends StatelessWidget {
  IconData icon;
  String value;
  buildContactRow({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, size: 20.0, color: Colors.black),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
