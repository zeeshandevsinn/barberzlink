import 'package:barberzlink/constants/app_strings.dart';
import 'package:barberzlink/core/routes/app_routes.dart';
import 'package:barberzlink/core/theme/app_colors.dart';
import 'package:barberzlink/view/main/job_board/job_board_barber_screen.dart';
import 'package:barberzlink/view/main/home/home_screen.dart';
import 'package:barberzlink/view/main/profile/profile_screen.dart';
import 'package:barberzlink/view/main/search_explore/search_explore_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final int index;
  const MainPage({super.key, required this.index});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      setState(() {
        _selectedIndex = widget.index;
      });
    }
  }

  final List<Map<String, String>> _categories = [
    {
      "title": "Barbershop",
      "image": AppStrings.barbershopImage,
      "route": AppRoutes.barberShop_search
    },
    // {"title": "Beauty Salon", "image": "assets/beauty_salon.jpg"},
    // {"title": "Spa", "image": "assets/spa.jpg"},
    // {"title": "Massage", "image": AppStrings.massageImage},
    // {"title": "Nail Salon", "image": AppStrings.nailSalonImage},
    // {"title": "Tattoo Parlor", "image": AppStrings.tattooParlorImage},
    {
      "title": "Barbers",
      "image": AppStrings.barberImage,
      "route": AppRoutes.barber_search
    },
    {
      "title": "Events",
      "image": AppStrings.eventImage,
      "route": AppRoutes.event_search
    },
    {
      "title": "Schools and Training",
      "image": AppStrings.schoolImage,
      "route": AppRoutes.school_search
    },
    {
      "title": "New Products",
      "image": AppStrings.newProductImage,
      "route": AppRoutes.newProductSearch
    },
    {
      "title": "State By State",
      "image": AppStrings.stateByStateImage,
      "route": AppRoutes.state_by_state_search
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _buildBody(),
        // Custom Bottom Navigation Bar
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(categories: _categories);
      case 1:
        return const SearchExploreScreen();
      case 2:
        return const JobBoardBarberScreen();
      case 3:
      default:
        return const AccountProfileScreen();
    }
  }
}
