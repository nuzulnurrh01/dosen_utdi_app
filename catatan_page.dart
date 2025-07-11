import 'package:flutter/material.dart';

class CatatanPage extends StatefulWidget {
  @override
  _CatatanPageState createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  DateTime? selectedDate;
  String? kategori;

  List<String> kategoriList = ['Kehadiran', 'Nilai', 'Catatan Khusus'];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF0D47A1),
            colorScheme: ColorScheme.light(primary: Color(0xFF0D47A1)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() => selectedDate = picked);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null || kategori == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lengkapi semua field!')));
        return;
      }

      // Simpan ke Firebase nanti
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Catatan berhasil disimpan')));

      // Reset form
      setState(() {
        namaController.clear();
        catatanController.clear();
        kategori = null;
        selectedDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Catatan')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Form Catatan Mahasiswa',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Mahasiswa',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                value: kategori,
                items:
                    kategoriList.map((kategori) {
                      return DropdownMenuItem(
                        value: kategori,
                        child: Text(kategori),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() => kategori = value);
                },
                validator:
                    (value) => value == null ? 'Pilih kategori catatan' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: catatanController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Isi Catatan',
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Catatan tidak boleh kosong' : null,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          selectedDate == null
                              ? 'Pilih Tanggal'
                              : 'Tanggal: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (_) => selectedDate == null ? 'Pilih tanggal' : null,
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Simpan Catatan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D47A1),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
