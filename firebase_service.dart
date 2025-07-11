import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> tambahMahasiswa(Map<String, String> data) async {
    await FirebaseFirestore.instance.collection('mahasiswa').add(data);
  }

  static Stream<QuerySnapshot> getMahasiswaStream() {
    return FirebaseFirestore.instance.collection('mahasiswa').snapshots();
  }

  static Future<void> tambahCatatan(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('catatan').add(data);
  }

  static Stream<QuerySnapshot> getJadwalStream() {
    return FirebaseFirestore.instance.collection('jadwal').snapshots();
  }
}
