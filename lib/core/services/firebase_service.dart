import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
/// Provides a centralized service class for initializing and accessing Firebase
/// instances (Firestore, Auth, Storage, etc.). Used as the single point of contact
/// for Firebase throughout the app.

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static Future<void> init() async {
    await Firebase.initializeApp();
  }
}
