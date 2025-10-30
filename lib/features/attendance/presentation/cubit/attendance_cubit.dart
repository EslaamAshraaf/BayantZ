import 'package:flutter_bloc/flutter_bloc.dart';
import 'attendance_state.dart';
import '../../data/repositories/attendance_repository.dart';
import 'package:bayantz_flutter_task/features/attendance/data/models/attendance_model.dart';
/// Manages the application state for attendance features.
/// Handles data fetching, search, filter, and refresh actions.
/// Emits AttendanceLoading, AttendanceLoaded, and AttendanceError states.

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepository repository;
  List<AttendanceModel> _allAttendance = []; // Store full data

  AttendanceCubit({required this.repository}) : super(AttendanceInitial());

  Future<void> fetchAttendance() async {
    try {
      emit(AttendanceLoading());
      final data = await repository.getAttendanceData();
      _allAttendance = data;
      emit(AttendanceLoaded(data));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  void applyFilter(Map<String, dynamic> filters) {
    if (_allAttendance.isEmpty) return;

    final status = filters['status'] as String?;
    final attendanceDate = filters['attendanceDate'] as DateTime?;
    final leavingTime = filters['leavingTime'] as DateTime?;

    // Apply filters step by step
    final filtered = _allAttendance.where((record) {
      bool matches = true;

      // ✅ Filter by status (case-insensitive)
      if (status != null && status.isNotEmpty) {
        matches &= record.status.toLowerCase() == status.toLowerCase();
      }

      // ✅ Filter by attendance date (compare only date part)
      if (attendanceDate != null && record.date.isNotEmpty) {
        try {
          final recordDate = DateTime.parse(record.date.split(' ').first); // 'yyyy-MM-dd'
          final filterDate = DateTime(attendanceDate.year, attendanceDate.month, attendanceDate.day);
          matches &= recordDate.year == filterDate.year &&
              recordDate.month == filterDate.month &&
              recordDate.day == filterDate.day;
        } catch (_) {}
      }

      // ✅ Filter by leaving date (compare only date part)
      if (leavingTime != null && record.leaving.isNotEmpty) {
        try {
          final recordLeaving = DateTime.parse(record.leaving.split(' ').first);
          final filterLeaving = DateTime(leavingTime.year, leavingTime.month, leavingTime.day);
          matches &= recordLeaving.year == filterLeaving.year &&
              recordLeaving.month == filterLeaving.month &&
              recordLeaving.day == filterLeaving.day;
        } catch (_) {}
      }

      return matches;
    }).toList();

    // Sort numerically by 'no' after filtering
    filtered.sort((a, b) => (int.tryParse(a.no) ?? 0).compareTo(int.tryParse(b.no) ?? 0));

    emit(AttendanceLoaded(filtered));
  }

  void resetFilter() {
    emit(AttendanceLoaded(_allAttendance));
  }
}
