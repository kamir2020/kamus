import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'object-word.dart';
import 'screen-dashboard.dart';

class TextSearch extends StatefulWidget {
  final String keywordText;
  const TextSearch({required this.keywordText});

  @override
  _TextSearchState createState() => _TextSearchState();
}

class _TextSearchState extends State<TextSearch> {
  late AudioPlayer audioPlayer;
  bool playing = false;
  late Future<List<Word>> futureWords;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    futureWords = _getRequest();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playRecording(String audioName) async {
    try {
      setState(() => playing = true);
      Source urlSource = UrlSource("https://kamususuluddin.com/audio/$audioName");
      await audioPlayer.play(urlSource);
      audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        if (state == PlayerState.completed) {
          setState(() => playing = false);
        }
      });
    } catch (e) {
      print("Error playing: $e");
    }
  }

  Future<void> pauseRecording() async {
    await audioPlayer.pause();
    setState(() => playing = false);
  }

  Future<List<Word>> _getRequest() async {
    final url =
        "https://kamususuluddin.com/api/api-get.php?action=get-word&keyword=${widget.keywordText}";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return (data as List).map((json) => Word(
      id: json["id"],
      keyword1: json["keyword1"],
      keyword2: json["keyword2"],
      description: json["description"],
      audioName: json["audioName"],
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil Carian", style: GoogleFonts.poppins()),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg_2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Word>>(
          future: futureWords,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text("Tiada hasil ditemui.",
                    style: GoogleFonts.poppins(fontSize: 16)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final word = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(word.keyword1,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo)),
                        Text(word.keyword2,
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Text(word.description,
                            style: GoogleFonts.poppins(fontSize: 14)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                playing
                                    ? pauseRecording()
                                    : playRecording(word.audioName);
                              },
                              icon: Icon(
                                  playing
                                      ? Icons.pause
                                      : Icons.play_circle_fill,
                                  size: 28,color: Colors.white,),
                              label: Text("Dengar",style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: playing
                                    ? Colors.deepOrange
                                    : Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
