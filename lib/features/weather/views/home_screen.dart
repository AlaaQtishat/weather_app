// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weather_app/core/widgets/container_background.dart';
// import 'package:weather_app/features/location/cubit/location_cubit.dart';
// import 'package:weather_app/features/location/cubit/location_state.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ContainerBackground(
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BlocProvider(
//               create: (context) => LocationCubit()..fetchUserLocation(),
//               child: Center(
//                 child: BlocBuilder<LocationCubit, LocationState>(
//                   builder: (context, state) {
//                     if (state is LocationLoading) {
//                       return const CircularProgressIndicator();
//                     } else if (state is LocationLoaded) {
//                       return Text(
//                         "Your Location:\n${state.cityName}",
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       );
//                     } else if (state is LocationError) {
//                       return Text(
//                         state.errorMessage,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(color: Colors.red, fontSize: 16),
//                       );
//                     }
//
//                     return const Text("Waiting...");
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/app_theme.dart';
import 'package:weather_app/core/widgets/container_background.dart';
import 'package:weather_app/core/widgets/header_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBackground(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                HeaderSection(isHome: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
