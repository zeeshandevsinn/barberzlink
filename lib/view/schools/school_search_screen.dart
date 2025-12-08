import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_list_card.dart';
import 'package:barberzlink/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/app_routes.dart';

class SchoolSearchScreen extends StatefulWidget {
  const SchoolSearchScreen({super.key});

  @override
  State<SchoolSearchScreen> createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolSearchScreen> {
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController cityAndZipController = TextEditingController();
  String selectedState = 'All States';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: kIsWeb
            ? AppBar(
                title: const Text("School Search"),
                centerTitle: true,
                elevation: 1)
            : PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: CustomAppBar(
                  title: 'School Search',
                  isBack: true,
                ),
              ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ======== Top Banner Section ========
              Stack(
                children: [
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Image.asset(
                      AppStrings.schoolImage,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Title
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "schools",
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
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  """
      Promote your programs and certifications to a nationwide audience
Highlight faculty, curriculum, and student success stories
Connect with prospective students and industry employers
List job placements, workshops, and enrollment opportunities
""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
                  child: CustomSearchBar(
                      keywordController: keywordController,
                      cityController: cityAndZipController,
                      selectedState: selectedState,
                      states: Injections.instance.states,
                      onStateChanged: (e) {
                        setState(() {
                          selectedState = e ?? '';
                        });
                      },
                      onSearch: () {})),

              const SizedBox(height: 20),

              // Job Card
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CustomListCard(
                      imagePath: AppStrings.schoolImage,
                      name: "American Barber Institute",
                      location: "48 West 39th Street New York, NY 10018",
                      onPressed: () {
                        AppRoutes.goTo(context, AppRoutes.school_detail);
                      },
                    ),
                  );
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
