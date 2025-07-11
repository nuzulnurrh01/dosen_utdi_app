import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class MahasiswaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Mahasiswa"),
        backgroundColor: Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.getMahasiswaStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs;

          if (data.isEmpty) {
            return Center(child: Text('Belum ada data mahasiswa'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final mhs = data[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF0D47A1),
                    child: Text(
                      mhs['nama'][0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    mhs['nama'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${mhs['nim']} • ${mhs['jurusan']}"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Bisa diarahkan ke halaman detail mahasiswa
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
