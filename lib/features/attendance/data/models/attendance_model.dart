/// Data model representing an employee's attendance record.
/// Includes fields for name, status, date, check-in/out, and total hours.

class AttendanceModel {
  final String no;
  final String date;
  final String oncoming;
  final String leaving;
  final String breakTime;
  final String status;
  final String total;

  AttendanceModel({
    required this.no,
    required this.date,
    required this.oncoming,
    required this.leaving,
    required this.breakTime,
    required this.status,
    required this.total,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      no: map['no']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      oncoming: map['oncoming']?.toString() ?? '',
      leaving: map['leaving']?.toString() ?? '',
      breakTime: map['break']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      total: map['total']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'date': date,
      'oncoming': oncoming,
      'leaving': leaving,
      'break': breakTime,
      'status': status,
      'total': total,
    };
  }

  /// ✅ Helper for numeric sorting
  int get noAsInt {
    final parsed = int.tryParse(no);
    return parsed ?? 0;
  }
}
