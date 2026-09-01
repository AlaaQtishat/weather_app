import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/features/main_layout/cubit/navigation_cubit.dart';
import 'package:weather_app/features/weather/views/forecast_screen.dart';
import 'package:weather_app/features/weather/views/home_screen.dart';
import 'package:weather_app/features/user/views/profile_screen.dart';
import 'package:weather_app/features/search/views/search_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    const SearchScreen(),
    const ForecastScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: IndexedStack(index: currentIndex, children: _screens),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF1A1E3A) : Color(0xFFE3ECFB),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: isDark
                  ? AppTheme.darkSelected
                  : AppTheme.lightSelected,
              unselectedItemColor: isDark
                  ? AppTheme.darkUnselected
                  : AppTheme.lightUnselected,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavigationCubit>().changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  label: "Forecast",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined),
                  label: "Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
