import 'package:barberzlink/view/authtentication/register/selection/registeration_selection_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: RegistrationSelectionScreen());
  }
}
