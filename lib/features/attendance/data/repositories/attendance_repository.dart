import 'package:bayantz_flutter_task/features/attendance/data/models/attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/// Handles all Firestore operations for attendance data.
/// Fetches employee attendance, listens for real-time updates,
/// and maps Firestore documents to AttendanceModel objects.
/// Used by the Cubit layer through usecases or direct injection.

class AttendanceRepository {
  final FirebaseFirestore firestore;

  AttendanceRepository({required this.firestore});

  Future<List<AttendanceModel>> getAttendanceData() async {
    try {
      final snapshot = await firestore.collection('attendence').get();

      final data = snapshot.docs
          .map((doc) => AttendanceModel.fromMap(doc.data()))
          .toList();

      // Sort numerically by 'no'
      data.sort((a, b) {
        final aNo = int.tryParse(a.no) ?? 0;
        final bNo = int.tryParse(b.no) ?? 0;
        return aNo.compareTo(bNo);
      });

      return data;
    } catch (e) {
      throw Exception('Failed to load attendance data: $e');
    }
  }
}
