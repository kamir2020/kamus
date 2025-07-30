import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen-dashboard.dart';

class ScreenIntro extends StatefulWidget {
  @override
  _ScreenIntro createState() => _ScreenIntro();
}

class _ScreenIntro extends State<ScreenIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text(
          'Pengenalan',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScreenDashboard()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Optional icon/hero section
              Center(
                child: Icon(
                  Icons.school_rounded,
                  size: 100,
                  color: Colors.indigo.shade300,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  'Mukjām Usuluddin merupakan satu inisiatif berteknologi tinggi yang menggabungkan kaedah Kecerdasan Buatan (AI) untuk membolehkan pengguna membuat carian pantas, tepat dan berstruktur terhadap konsep-konsep utama dalam Usuluddin. '
                      'Dengan menyatukan teknologi pemprosesan bahasa semula jadi (Natural Language Processing - NLP) dan pengecaman pertuturan (Speech Recognition), '
                      'sistem ini membolehkan carian dilakukan bukan sahaja melalui teks bertulis, malah juga melalui audio dan rakaman suara.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF3F5F9),
    );
  }
}
