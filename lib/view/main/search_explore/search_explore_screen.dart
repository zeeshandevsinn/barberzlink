import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/injections.dart';
import 'package:barberzlink/widgets/custom_app_bar.dart';
import 'package:barberzlink/widgets/custom_event_card.dart';
import 'package:barberzlink/widgets/custom_textfield.dart';
import 'package:barberzlink/widgets/featured_product_card.dart';
import 'package:barberzlink/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/routes/app_routes.dart';
import '../../../widgets/custom_barbershop_card.dart';
import '../../../widgets/custom_list_card.dart';

class SearchExploreScreen extends StatefulWidget {
  const SearchExploreScreen({super.key});

  @override
  State<SearchExploreScreen> createState() => _SearchExploreScreenState();
}

class _SearchExploreScreenState extends State<SearchExploreScreen> {
  String _selectedState = "All States";
  int _activeTab = 0;
  final TextEditingController _searchKeyWordController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final List<String> tabs = [
    "All",
    "Barbers",
    "BarberShop",
    "Events",
    "Schools",
    "Featured Product",
    "State-by-State",
  ];

  final List<Map<String, dynamic>> allItems = [
    {
      "title": "Top Barber of LA",
      "subtitle": "Professional Haircut & Styling",
      "image": AppStrings.barberImage
    },
    {
      "title": "NY Barber Shop Expo",
      "subtitle": "Largest Barber Festival",
      "image": AppStrings.barbershopImage
    },
    {
      "title": "Texas Barber School",
      "subtitle": "Become a Certified Barber",
      "image": AppStrings.barberImage
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(title: 'Explore & Search')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              // 🔍 SEARCH BAR
              CustomTextField(
                hintText: "Search services or businesses",
                label: "Search",
                controller: _searchKeyWordController,
                icon: Icons.search,
              ),

              SizedBox(height: 10.h),

              // 📍 CITY + STATE DROPDOWN
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Where?",
                      label: "City",
                      controller: _cityController,
                      icon: Icons.location_city,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(child: _buildStateDropdown()),
                ],
              ),

              SizedBox(height: 14.h),

              // 📌 TABS
              SizedBox(
                height: 40.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    final selected = index == _activeTab;
                    return GestureDetector(
                      onTap: () => setState(() => _activeTab = index),
                      child: Container(
                        margin: EdgeInsets.only(right: 18.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color:
                                  selected ? Colors.black : Colors.transparent,
                            ),
                          ),
                        ),
                        child: Text(
                          tabs[index],
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w400,
                            color:
                                selected ? Colors.black : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10.h),

              // 🎠 CONTENT AREA - FIXED: Removed nested Expanded
              Expanded(
                child: _buildCurrentTabContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildAllSection();
      case 1:
        return _buildBarbersTab();
      case 2:
        return _buildBarberShopTab();
      case 3:
        return _buildEventTab();
      case 4:
        return _buildSchoolTab();
      case 5:
        return _buildFeatureProductTab();
      case 6:
        return _buildStateByStateTab();
      default:
        return _buildAllSection();
    }
  }

  // 🏛 STATE DROPDOWN
  Widget _buildStateDropdown() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.black26),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedState,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.grey.shade600,
          ),
          dropdownColor: Colors.white,
          items: Injections.instance.states
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
          onChanged: (value) {
            setState(() => _selectedState = value!);
          },
        ),
      ),
    );
  }

  Widget buildHorizontalSection({
    required String title,
    required List<Map<String, dynamic>> data,
    required Widget Function(Map<String, dynamic>) cardBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: title == "Barbers" ||
                  title == "Featured Barbers" ||
                  title == "Schools"
              ? 260.h
              : title == "Events"
                  ? 430.h
                  : 330.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                width: 300.w, // FIXED: Added explicit width
                margin: EdgeInsets.only(right: 12.w),
                child: cardBuilder(data[index]),
              );
            },
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget buildBarberCard(Map<String, dynamic> barber) {
    return CustomListCard(
      imagePath: barber['image'],
      name: barber['name'],
      location: barber['location'],
      onPressed: () {
        AppRoutes.goTo(context, AppRoutes.barber_detail);
      },
    );
  }

  Widget buildBarberShopCard(Map<String, dynamic> shop) {
    return CustomBarberShopCard(
      imagePath: shop['image'],
      name: shop['name'],
      owner: shop['owner'],
      location: shop['location'],
      rating: shop['rating'],
      description: shop['description'],
      onPressed: () {
        AppRoutes.goTo(context, AppRoutes.barberShop_detail);
      },
    );
  }

  Widget buildEventCard(Map<String, dynamic> event) {
    return CustomEventCard(
      imagePath: event['image'],
      title: event['title'],
      address: event['address'],
      jobDetails: event['jobDetails'],
      onPressed: () {
        AppRoutes.goTo(context, AppRoutes.event_detail);
      },
    );
  }

  Widget buildSchoolCard(Map<String, dynamic> school) {
    return CustomListCard(
      imagePath: school['image'],
      name: school['name'],
      location: school['location'],
      onPressed: () {
        AppRoutes.goTo(context, AppRoutes.school_detail);
      },
    );
  }

  Widget _buildAllSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1️⃣ BARBERS
          buildHorizontalSection(
            title: "Barbers",
            data: Injections.instance.barbersData,
            cardBuilder: buildBarberCard,
          ),

          // 2️⃣ BARBERSHOP
          buildHorizontalSection(
            title: "Barber Shops",
            data: Injections.instance.barberShopsData,
            cardBuilder: buildBarberShopCard,
          ),

          // 3️⃣ EVENTS
          buildHorizontalSection(
            title: "Events",
            data: Injections.instance.eventsData,
            cardBuilder: buildEventCard,
          ),

          // 4️⃣ SCHOOLS
          buildHorizontalSection(
            title: "Schools",
            data: Injections.instance.schoolsData,
            cardBuilder: buildSchoolCard,
          ),

          // 5️⃣ FEATURED PRODUCTS
          buildHorizontalSection(
            title: "Featured Products",
            data: Injections.instance.featuredProducts,
            cardBuilder: (product) => FeaturedProductCard(
              image: product["image"],
              title: product["title"],
              subtitle: product["subtitle"],
              onTap: () {
                AppRoutes.goTo(context, product["route"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarbersTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ⭐ FEATURED BARBERS HORIZONTAL

          SizedBox(height: 20.h),

          // ⭐ NORMAL LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Injections.instance.barbersData.length,
            itemBuilder: (context, index) {
              final barber = Injections.instance.barbersData[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: buildBarberCard(barber),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBarberShopTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // ⭐ NORMAL LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Injections.instance.barberShopsData.length,
            itemBuilder: (context, index) {
              final barberShop = Injections.instance.barberShopsData[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: buildBarberShopCard(barberShop),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // ⭐ NORMAL LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Injections.instance.eventsData.length,
            itemBuilder: (context, index) {
              final event = Injections.instance.eventsData[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: buildEventCard(event),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // ⭐ NORMAL LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Injections.instance.schoolsData.length,
            itemBuilder: (context, index) {
              final schools = Injections.instance.schoolsData[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: buildSchoolCard(schools),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureProductTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // ⭐ NORMAL LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Injections.instance.featuredProducts.length,
            itemBuilder: (context, index) {
              final featureProducts =
                  Injections.instance.featuredProducts[index];
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: FeaturedProductCard(
                      image: featureProducts['image'],
                      title: featureProducts['title'],
                      subtitle: featureProducts['subtitle'],
                      onTap: () {
                        AppRoutes.goTo(context, featureProducts["route"]);
                      }));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStateByStateTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          // ⭐ STATE LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Injections.instance.statesData.length,
            itemBuilder: (context, index) {
              final state = Injections.instance.statesData[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: StateCard(
                    state: state,
                    onTap: () {
                      AppRoutes.goTo(context, AppRoutes.state_by_state_details);
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
