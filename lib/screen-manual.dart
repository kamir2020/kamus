import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen-dashboard.dart';

class ScreenManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Pengguna", style: GoogleFonts.poppins()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => ScreenDashboard()));
          },
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text("Bahagian Antaramuka Pengguna",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                manualItem(Icons.search, "Mencari istilah berdasarkan kata kunci", Colors.indigo),
                manualItem(Icons.category, "Memilih istilah berdasarkan bidang (Tauhid, Tasawuf, dll)", Colors.deepPurple),
                manualItem(Icons.volume_up, "Mainkan bacaan istilah dan definisi", Colors.orange),
                manualItem(Icons.text_fields, "Paparan teks definisi penuh", Colors.blue),
                manualItem(Icons.settings, "Kawal kelantangan audio, bahasa, atau tema paparan", Colors.grey.shade700),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget manualItem(IconData icon, String text, Color color) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 30, color: color.withOpacity(0.85)),
          title: Text(text, style: GoogleFonts.poppins(fontSize: 15)),
        ),
        Divider(),
      ],
    );
  }
}
