import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/state_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/app_routes.dart';
import '../../widgets/custom_state_dropdown.dart';

class StateByStateSearchScreen extends StatefulWidget {
  const StateByStateSearchScreen({super.key});

  @override
  State<StateByStateSearchScreen> createState() =>
      _StateByStateSearchScreenState();
}

class _StateByStateSearchScreenState extends State<StateByStateSearchScreen> {
  List<String> selectedState = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: kIsWeb
            ? AppBar(
                title: Text("State-by-State Board Requirements"),
                centerTitle: true,
                elevation: 1)
            : PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: CustomAppBar(
                  title: 'State-by-State Board Requirements',
                  isBack: true,
                ),
              ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ======== Top Banner Section ========
              SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.asset(
                  AppStrings.stateByStateImage,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "State-by-State Board Requirements",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.7),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  """
      Our platform allows barber schools and programs to promote their certifications and training nationwide, reaching students and professionals across every state. You can showcase your faculty expertise, curriculum, and student success stories to highlight the quality of your program. Connect directly with prospective students and industry employers, increasing visibility and engagement. Additionally, you can list job placements, workshops, and enrollment opportunities, helping students transition smoothly from training to career while meeting each state’s board requirements.
""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomSearchableDropdown(
                  items: Injections.instance.states
                      .where((state) => state != 'All States')
                      .toList(),
                  selectedItems: selectedState,
                  onChanged: (newState) {
                    setState(() {
                      selectedState = newState;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Job Card
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Injections.instance.statesData.length,
                itemBuilder: (context, index) {
                  final state = Injections.instance.statesData[index];
                  return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: StateCard(
                          state: state,
                          onTap: () {
                            AppRoutes.goTo(
                                context, AppRoutes.state_by_state_details,
                                arguments: state);
                          }));
                },
              )

              /*const SizedBox(height: 40),
      
              const FooterSection(),*/
            ],
          ),
        ),
      ),
    );
  }
}
