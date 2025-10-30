import 'package:bayantz_flutter_task/Core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Core/constants/App_Colors.dart';
import '../../../../core/utils/theme_manager.dart';
import '../cubit/attendance_cubit.dart';
import 'export_dialog.dart';
import 'filter_dialog.dart';

class AttendanceCard extends StatefulWidget {
  const AttendanceCard({super.key});

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  bool showContainer = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isLight = themeMode == ThemeMode.light;
        final cardColor = isLight ? AppColors.card : AppColors.darkCard;
        final buttonColor = isLight ? AppColors.buttonBackground : AppColors.darkButtonBackground;
        final textColor = isLight ? Colors.black : Colors.white; // Change black to white in dark mode

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show/Hide
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => setState(() => showContainer = !showContainer),
                  child: Text(
                    "Show/Hide",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // User Card
              if (showContainer)
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppIcons.User, width: 60, height: 60),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Amro Handousa", style: TextStyle(color: textColor)),
                              const SizedBox(height: 4),
                              Text("Marketing", style: TextStyle(color: textColor)),
                              const SizedBox(height: 2),
                              Text("Marketing Manager", style: TextStyle(color: textColor)),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppIcons.checkIn, width: 24, height: 24),
                          label: const Text("Check In"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              // Dashboard Tabs
              Row(
                children: [
                  Text("Dashboard", style: TextStyle(color: textColor)),
                  const SizedBox(width: 24),
                  Text("Attendance", style: TextStyle(color: textColor)),
                  const SizedBox(width: 24),
                  Text("Requests", style: TextStyle(color: textColor)),
                ],
              ),
              const SizedBox(height: 16),

              // Attendance Boxes
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AttendanceBox(
                      items: [
                        AttendanceItem(icon: AppIcons.present, label: 'Present', value: '03', color: AppColors.present),
                        AttendanceItem(icon: AppIcons.absent, label: 'Absent', value: '05', color: AppColors.absent),
                      ],
                      textColor: textColor,
                    ),
                    const SizedBox(width: 12),
                    AttendanceBox(
                      items: [
                        AttendanceItem(icon: AppIcons.late, label: 'Late', value: '01', color: AppColors.late),
                        AttendanceItem(icon: AppIcons.excused, label: 'Vacation', value: '08', color: AppColors.excused),
                      ],
                      textColor: textColor,
                    ),
                    const SizedBox(width: 12),
                    AttendanceBox(
                      items: [
                        AttendanceItem(icon: AppIcons.sickLeave, label: 'Sick Leave', value: '01', color: AppColors.excused),
                        AttendanceItem(icon: AppIcons.excused, label: 'Excused', value: '08', color: AppColors.excused),
                      ],
                      textColor: textColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Search + Filter + Export
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          SvgPicture.asset(
                            AppIcons.search,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      final filterData = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) => const FilterDialog(),
                      );
                      if (filterData != null) {
                        context.read<AttendanceCubit>().applyFilter(filterData);
                      }
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.filter,
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 6),
                          Text("Filter", style: TextStyle(color: textColor)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      final fileName = await showDialog<String>(
                        context: context,
                        builder: (context) => const ExportDialog(),
                      );
                      if (fileName != null && fileName.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Exporting file: $fileName', style: TextStyle(color: textColor))),
                        );
                      }
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.export,
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 6),
                          const Text("Export", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Attendance Item
class AttendanceItem {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const AttendanceItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}

// Attendance Box
class AttendanceBox extends StatelessWidget {
  final List<AttendanceItem> items;
  final Color textColor;

  const AttendanceBox({super.key, required this.items, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;

    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) => _AttendanceRow(item: item, textColor: textColor)).toList(),
      ),
    );
  }
}

// Attendance Row
class _AttendanceRow extends StatelessWidget {
  final AttendanceItem item;
  final Color textColor;

  const _AttendanceRow({required this.item, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
            child: SvgPicture.asset(item.icon, width: 20, height: 20, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(item.label, style: TextStyle(color: textColor))),
          Text(item.value, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
