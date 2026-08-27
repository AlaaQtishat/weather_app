import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/debouncer.dart';
import 'package:weather_app/features/search/cubit/search_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Debouncer debouncer;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.debouncer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (value.trim().isEmpty) {
            debouncer.dispose();
            context.read<SearchCubit>().resetSearch();
            return;
          }
          debouncer.run(() {
            context.read<SearchCubit>().getSearchResult(value);
          });
        },
        onSubmitted: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: "Find your city",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 24.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18.h),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
              context.read<SearchCubit>().resetSearch();
            },
            icon: const Icon(Icons.close, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
