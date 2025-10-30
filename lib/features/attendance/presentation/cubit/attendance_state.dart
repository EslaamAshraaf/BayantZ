import 'package:equatable/equatable.dart';
import 'package:bayantz_flutter_task/features/attendance/data/models/attendance_model.dart';
/// Defines all states emitted by AttendanceCubit.
/// Includes Loading, Loaded, and Error variants, each representing
/// a different phase of data handling in the UI.

abstract class AttendanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceModel> attendanceList;
  AttendanceLoaded(this.attendanceList);

  @override
  List<Object?> get props => [attendanceList];
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}
