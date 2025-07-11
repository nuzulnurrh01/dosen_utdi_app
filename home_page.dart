import 'package:flutter/material.dart';
import 'mahasiswa_page.dart'; // Import halaman Mahasiswa
import 'jadwal_page.dart';
import 'catatan_page.dart';
// atau
// import 'mahasiswa_dummy_page.dart'; // untuk versi dummy

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Dosen', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0D47A1),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Kembali ke login
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, Dosen UTDI 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
            SizedBox(height: 30),
            buildMenuButton(
              icon: Icons.group,
              label: 'Daftar Mahasiswa',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MahasiswaPage()),
                );
              },
            ),
            buildMenuButton(
              icon: Icons.schedule,
              label: 'Jadwal Kuliah',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => JadwalPage()),
                );
              },
            ),
            buildMenuButton(
              icon: Icons.note_alt,
              label: 'Tambah Catatan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CatatanPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF0D47A1)),
        title: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
