import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:bayantz_flutter_task/Core/constants/app_icons.dart';
/// Dialog widget for filtering attendance records by status, date, or keyword.
/// Includes input validation and communicates selected filters to AttendanceCubit.

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _status;
  DateTime? _attendanceDate;
  DateTime? _leavingTime;

  final _statusOptions = ['Present', 'Absent', 'Late', 'On Leave'];

  Future<void> _pickDate(BuildContext context, {required bool isAttendance}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isAttendance) {
          _attendanceDate = picked;
        } else {
          _leavingTime = picked;
        }
      });
    }
  }

  void _reset() {
    setState(() {
      _status = null;
      _attendanceDate = null;
      _leavingTime = null;
    });
    _formKey.currentState?.reset();
  }

  void _apply() {
    Navigator.pop(context, {
      'status': _status,
      'attendanceDate': _attendanceDate,
      'leavingTime': _leavingTime,
    });
  }


  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.filter,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Filter",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Fields
                Wrap(
                  runSpacing: 12,
                  spacing: 12,
                  children: [
                    SizedBox(
                      width: 230,
                      child: DropdownButtonFormField<String>(
                        value: _status,
                        items: _statusOptions
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        decoration: _inputDecoration('Status'),
                        onChanged: (val) => setState(() => _status = val),
                        validator: (val) => val == null ? 'Required' : null,
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      child: TextFormField(
                        readOnly: true,
                        decoration: _inputDecoration(
                          'Attendance Date',
                          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
                        ),
                        controller: TextEditingController(
                          text: _attendanceDate == null
                              ? ''
                              : dateFormat.format(_attendanceDate!),
                        ),
                        onTap: () => _pickDate(context, isAttendance: true),
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      child: TextFormField(
                        readOnly: true,
                        decoration: _inputDecoration(
                          'Leaving Time',
                          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
                        ),
                        controller: TextEditingController(
                          text: _leavingTime == null
                              ? ''
                              : dateFormat.format(_leavingTime!),
                        ),
                        onTap: () => _pickDate(context, isAttendance: false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _grayButton('Reset', onPressed: _reset),
                    _grayButton('Apply', onPressed: _apply),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _grayButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      width: 110,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBDBDBD),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(text),
      ),
    );
  }
}
