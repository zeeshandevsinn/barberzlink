import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_event_card.dart';
import 'package:barberzlink/widgets/keyword_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventSearchScreen extends StatefulWidget {
  const EventSearchScreen({super.key});

  @override
  State<EventSearchScreen> createState() => _EventSearchScreenState();
}

class _EventSearchScreenState extends State<EventSearchScreen> {
  final TextEditingController keywordController = TextEditingController();
  String selectedState = 'All States';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(
            title: 'Event Search',
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
                      AppStrings.eventImage,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Title
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Events",
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
      Get ready to sharpen your skills and connect with fellow barbers at the exciting events lined up in the barbershop community, where artistry and camaraderie blend seamlessly to inspire creativity and growth. From hands-on workshops featuring industry leaders to vibrant competitions that showcase the finest talents, these gatherings promise to be a hub of innovation and connection.
      
      Join us as we celebrate the craft, exchange ideas, and foster friendships that extend beyond the chair. Whether you’re a seasoned pro or just starting your journey, these events are your gateway to a thriving network, empowering you to elevate your craft and enrich the experience of your clients.
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
                child: KeywordSearchBar(
                  keywordController: keywordController,
                  selectedState: selectedState,
                  states: Injections.instance.states,
                  onStateChanged: (value) {
                    setState(() => selectedState = value!);
                  },
                  onSearch: () {
                    print("Keyword: ${keywordController.text}");

                    print("State: $selectedState");
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Job Card
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Injections.instance.eventsData.length,
                itemBuilder: (context, index) {
                  final event = Injections.instance.eventsData[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomEventCard(
                      imagePath: event['image'],
                      title: event['title'],
                      address: event['address'],
                      jobDetails: event['jobDetails'],
                      onPressed: () {
                        print("View Details for ${event['title']}");
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
