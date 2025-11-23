import 'package:barberzlink/models/state_profile_model.dart';
import 'package:flutter/material.dart';

class StateDetailScreen extends StatelessWidget {
  final StateProfileModel state;

  const StateDetailScreen({super.key, required this.state});

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(state.stateName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            buildRow("1. State Name:", state.stateName),
            buildRow("2. State Barber Board Name:", state.boardName),
            buildRow("3. Official Website Link:", state.websiteLink),
            buildRow("4. Transfer / Reciprocity:", state.transferLink),
            buildRow("5. Testing Site Link:", state.testingSiteLink),
            buildRow("6. Military Policy Link:", state.militaryPolicyLink),
          ],
        ),
      ),
    );
  }
}
