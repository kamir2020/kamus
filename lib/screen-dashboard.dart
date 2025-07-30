import 'package:app_kamus/screen-ai.dart';
import 'package:app_kamus/screen-form1.dart';
import 'package:app_kamus/screen-intro.dart';
import 'package:app_kamus/screen-manual.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'screen-audio-search.dart';
import 'screen-text-search.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  _ScreenDashboardState createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _keyword = TextEditingController();
  final SpeechToText speechToText = SpeechToText();

  bool isListening = false;
  bool isLoading = false;
  String recognizedText = '';

  int _currentIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(_buildMainContent());
  }

  void _goToSearch(String keyword) {
    Navigator.push(context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => TextSearch(keywordText: keyword),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ));
  }

  void _goToAudioSearch(String msg) {
    Navigator.push(context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => AudioSearch(speechText: msg),
          transitionsBuilder: (_, animation, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ));
  }

  void _startListening() async {
    bool available = await speechToText.initialize();
    if (available) {
      setState(() => isListening = true);
      speechToText.listen(onResult: (result) {
        setState(() {
          recognizedText = result.recognizedWords;
          isListening = false;
          isLoading = true;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() => isLoading = false);
          _goToAudioSearch(recognizedText);
        });
      });
    }
  }

  void _stopListening() {
    speechToText.stop();
    setState(() => isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.menu_book_outlined, color: Colors.white,),
            SizedBox(width: 8),
            Text("Kamus Usuluddin", style: TextStyle(color: Colors.white),)
          ],
        ),
        backgroundColor: Colors.indigo,
      ),
      body: _pages[_currentIndex],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/logo_3.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Cari Makna Istilah",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _keyword,
                          decoration: InputDecoration(
                            hintText: 'Masukkan istilah...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (val) =>
                          val!.isEmpty ? 'Masukkan kata kunci' : null,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _goToSearch(_keyword.text);
                            }
                          },
                          icon: Icon(Icons.search, color: Colors.white,),
                          label: Text("Cari Sekarang", style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Atau gunakan suara anda',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: isListening ? _stopListening : _startListening,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isListening
                            ? Colors.indigo.shade300
                            : Colors.indigo.shade100,
                      ),
                      padding: EdgeInsets.all(16),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: AlwaysStoppedAnimation(isListening ? 1.0 : 0.0),
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: isLoading ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Text(
                        'Menganalisis suara...'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          Text("Menu", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.2,
            ),
            children: [
              buildGridItem(Icons.info, 'Pengenalan', Colors.indigo, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ScreenIntro()));
              }),
              buildGridItem(Icons.menu_book, 'Manual', Colors.green, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ScreenManual()));
              }),
              buildGridItem(Icons.smart_toy_outlined, 'AI', Colors.purple, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ScreenAI()));
              }),
              buildGridItem(Icons.lightbulb, 'Cadangan', Colors.orange, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ScreenForm1()));
              }),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/logo_4.png", width: 80, height: 80),
                SizedBox(width: 20),
                Image.asset("images/logo_6.png", width: 80, height: 80),
              ],
            ),
          ),
          Center(
            child: Text('Universiti Sultan Zainal Abidin \n&\nDewan Pustaka dan Bahasa',
              style: GoogleFonts.poppins(fontSize: 14), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }

  Widget buildGridItem(
      IconData icon, String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500, color: color),
            )
          ],
        ),
      ),
    );
  }
}
