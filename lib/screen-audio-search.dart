import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'object-word.dart';
import 'screen-dashboard.dart';

class AudioSearch extends StatefulWidget {
  final String speechText;
  const AudioSearch({required this.speechText});

  @override
  _AudioSearchState createState() => _AudioSearchState();
}

class _AudioSearchState extends State<AudioSearch> {
  late Future<List<Word>> futureWords;

  @override
  void initState() {
    super.initState();
    futureWords = _getRequest();
  }

  Future<List<Word>> _getRequest() async {
    final url =
        "https://kamususuluddin.com/api/api-get.php?action=get-word&keyword=${widget.speechText}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Word(
        id: json['id'],
        keyword1: json['keyword1'],
        keyword2: json['keyword2'],
        description: json['description'],
        audioName: json['audioName'],
      )).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Carian Audio', style: GoogleFonts.poppins()),
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
            } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Tiada hasil ditemui.',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final word = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(word.keyword1,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              )),
                          Text(word.keyword2,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          const SizedBox(height: 10),
                          Text(word.description,
                              style: GoogleFonts.poppins(fontSize: 14)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // playAudio(word.audioName); // future implementation
                                },
                                icon: Icon(Icons.play_arrow,color: Colors.white,),
                                label: Text("Main Audio",style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
