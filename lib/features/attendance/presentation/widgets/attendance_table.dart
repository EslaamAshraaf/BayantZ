import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/attendance_cubit.dart';
import '../cubit/attendance_state.dart';
import 'package:bayantz_flutter_task/Core/constants/App_Colors.dart';
/// Displays employee attendance data in a responsive DataTable.
/// Applies color coding to represent status (e.g., present/absent).
/// Supports scrolling for smaller screens.

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state is AttendanceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AttendanceLoaded) {
          final data = state.attendanceList;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isDark ? AppColors.darkCard : AppColors.card,
                ),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(AppColors.tableHeader),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  dataRowColor: MaterialStateProperty.all(
                      isDark ? AppColors.darkCard : AppColors.card),
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Attendance Date')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Oncoming Time')),
                    DataColumn(label: Text('Leaving Time')),
                    DataColumn(label: Text('Break Time')),
                    DataColumn(label: Text('Total Time')),
                  ],
                  rows: data.map((item) {
                    Color statusColor;
                    switch (item.status.toLowerCase()) {
                      case 'present':
                        statusColor = AppColors.present;
                        break;
                      case 'absent':
                        statusColor = AppColors.absent;
                        break;
                      case 'sick leave':
                        statusColor = AppColors.absent;
                        break;
                      case 'vacation':
                        statusColor = AppColors.excused;
                        break;
                      default:
                        statusColor = AppColors.excused;
                    }

                    final textColor = isDark ? Colors.white : AppColors.textPrimary;

                    return DataRow(
                      cells: [
                        DataCell(Text(item.no, style: TextStyle(color: textColor))),
                        DataCell(Text(item.date, style: TextStyle(color: textColor))),
                        DataCell(Text(
                          item.status,
                          style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
                        )),
                        DataCell(Text(item.oncoming, style: TextStyle(color: textColor))),
                        DataCell(Text(item.leaving, style: TextStyle(color: textColor))),
                        DataCell(Text(item.breakTime, style: TextStyle(color: textColor))),
                        DataCell(Text(item.total, style: TextStyle(color: textColor))),
                      ],
                    );
                  }).toList(),
                )

              ),
            ),
          );
        } else if (state is AttendanceError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
