import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen-dashboard.dart';

class ScreenForm1 extends StatefulWidget {
  @override
  _ScreenForm1 createState() => _ScreenForm1();
}

class _ScreenForm1 extends State<ScreenForm1> {
  late String _category = '';

  final TextEditingController kataCtrl = TextEditingController();
  final TextEditingController maknaCtrl = TextEditingController();
  final TextEditingController rujukanCtrl = TextEditingController();
  final TextEditingController cadanganCtrl = TextEditingController();

  void _openBottomSheet(BuildContext context, String category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    category == 'Cadangan Istilah'
                        ? Icons.translate
                        : Icons.lightbulb_outline,
                    size: 50,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                if (category == 'Cadangan Istilah') ...[
                  buildInputField("Kata", kataCtrl),
                  buildInputField("Makna", maknaCtrl),
                  buildInputField("Rujukan", rujukanCtrl),
                ] else ...[
                  buildInputField("Cadangan", cadanganCtrl),
                ],
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cadangan berjaya dihantar')),
                      );
                    },
                    icon: Icon(Icons.send),
                    label: Text("Hantar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          hintText: "Masukkan $label",
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text(
          'Cadangan Istilah',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScreenDashboard()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DropdownButtonFormField<String>(
          value: _category.isNotEmpty ? _category : null,
          decoration: InputDecoration(
            labelText: 'Pilih Kategori',
            labelStyle: GoogleFonts.poppins(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          items: [
            DropdownMenuItem(
              value: 'Cadangan Istilah',
              child: Row(
                children: [
                  Icon(Icons.translate, color: Colors.indigo),
                  SizedBox(width: 10),
                  Text('Cadangan Istilah', style: GoogleFonts.poppins()),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Cadangan Penambahbaikan',
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange),
                  SizedBox(width: 10),
                  Text('Cadangan Penambahbaikan', style: GoogleFonts.poppins()),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _category = value!;
            });
            _openBottomSheet(context, value!);
          },
          validator: (value) =>
          value == null || value.isEmpty ? 'Sila pilih kategori' : null,
        ),
      ),
      backgroundColor: Color(0xFFF3F5F9),
    );
  }
}
