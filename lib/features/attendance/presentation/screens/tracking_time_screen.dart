import 'package:bayantz_flutter_task/Core/constants/App_Colors.dart';
import 'package:bayantz_flutter_task/features/attendance/presentation/widgets/attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/constants/app_text_styles.dart';
import '../../../../core/utils/theme_manager.dart';
import '../../data/repositories/attendance_repository.dart';
import '../cubit/attendance_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/attendance_table.dart';
/// Main screen displaying employee attendance overview.
/// Integrates the table, filter button, export button, and search functionality.
/// Connects directly to AttendanceCubit for real-time data updates.

class TrackingTimeScreen extends StatelessWidget {
  const TrackingTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AttendanceCubit(
            repository: AttendanceRepository(firestore: FirebaseFirestore.instance),
          )..fetchAttendance(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return Scaffold(
                appBar: AppBar(
              backgroundColor: themeMode == ThemeMode.light
              ? AppColors.background
                : AppColors.darkBackground,
                  title: Text(
                    'Tracking Time',
                    style: AppTextStyles.title(context).copyWith(
                      color: themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                  ),
                actions: [
                  IconButton(
                    icon: Icon(
                      themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    ),
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  ),
                ],
              ),

              body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AttendanceCard(),
                      const SizedBox(height: 15),
                      const AttendanceTable(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
