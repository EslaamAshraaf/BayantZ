import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core/utils/theme_manager.dart';
import 'features/attendance/data/repositories/attendance_repository.dart';
import 'features/attendance/presentation/cubit/attendance_cubit.dart';
import 'features/attendance/presentation/screens/tracking_time_screen.dart';
import 'core/services/firebase_options.dart';
/// Entry point of the application. Initializes Firebase, sets up dependency injection,
/// and configures Bloc providers (ThemeCubit, AttendanceCubit, etc.) before launching
/// the root widget with responsive theme support (Light/Dark mode).
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()), // Theme management
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        // Firestore repository for attendance
        final attendanceRepository =
        AttendanceRepository(firestore: FirebaseFirestore.instance);

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
              AttendanceCubit(repository: attendanceRepository)..fetchAttendance(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BayanTZ Attendance',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const TrackingTimeScreen(),
          ),
        );
      },
    );
  }
}
