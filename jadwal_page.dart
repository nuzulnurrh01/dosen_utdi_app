import 'package:flutter/material.dart';

class JadwalPage extends StatefulWidget {
  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<Map<String, String>> jadwal = [
    {
      'matkul': 'Pemrograman Mobile',
      'hari': 'Senin',
      'jam': '08.00 - 10.00',
      'ruang': 'Lab 1',
    },
    {
      'matkul': 'Struktur Data',
      'hari': 'Rabu',
      'jam': '10.00 - 12.00',
      'ruang': 'Lab 2',
    },
    {
      'matkul': 'Framework Mobile',
      'hari': 'Jumat',
      'jam': '13.00 - 15.00',
      'ruang': 'Ruang U.2.4',
    },
  ];

  String searchQuery = '';
  String sortBy = 'Hari';

  @override
  Widget build(BuildContext context) {
    // 🔍 Filter hasil pencarian
    List<Map<String, String>> filteredJadwal =
        jadwal.where((item) {
          return item['matkul']!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              item['hari']!.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    // 🔃 Urutkan hasil
    filteredJadwal.sort(
      (a, b) =>
          sortBy == 'Hari'
              ? a['hari']!.compareTo(b['hari']!)
              : a['matkul']!.compareTo(b['matkul']!),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Jadwal Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari mata kuliah atau hari...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
            SizedBox(height: 12),

            // 🔃 Dropdown sortir
            Row(
              children: [
                Icon(Icons.sort, color: Color(0xFF0D47A1)),
                SizedBox(width: 8),
                Text('Urutkan berdasarkan:'),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: sortBy,
                  items:
                      ['Hari', 'Mata Kuliah'].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // 📅 List jadwal
            Expanded(
              child: ListView.builder(
                itemCount: filteredJadwal.length,
                itemBuilder: (context, index) {
                  final data = filteredJadwal[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['matkul']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 6),
                              Text("${data['hari']} • ${data['jam']}"),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.room, size: 16, color: Colors.grey),
                              SizedBox(width: 6),
                              Text("Ruang: ${data['ruang']}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
