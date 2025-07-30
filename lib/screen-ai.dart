import 'package:flutter/material.dart';

class ScreenAI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> aiFeatures = [
      {
        "title": "🔍 Carian Suara (Speech Recognition)",
        "desc":
        "Sebut istilah seperti 'Taqdir' dan AI akan mengenal pasti perkataan tersebut secara automatik untuk membantu carian dalam kamus."
      },
      {
        "title": "🗣️ Bacaan Teks (Text-to-Speech)",
        "desc":
        "Makna setiap istilah boleh didengarkan menggunakan teknologi AI Text-to-Speech bagi membantu pengguna memahami sebutan dan maksud."
      },
      {
        "title": "💡 Saranan Istilah Pintar",
        "desc":
        "AI akan mencadangkan istilah yang berkaitan semasa anda menaip, walaupun ejaan tidak tepat sepenuhnya."
      },
      {
        "title": "🧠 Carian Kontekstual",
        "desc":
        "AI memahami maksud yang anda cari berdasarkan konteks, bukan hanya padanan ejaan. Contohnya, cari 'keesaan' → AI paparkan 'Tawhid'."
      },
      {
        "title": "❓ Soal Jawab Interaktif",
        "desc":
        "Ciri kuiz interaktif AI membolehkan anda menjawab soalan asas Usuluddin dan mendapat maklum balas secara automatik."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Teknologi AI",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal.shade600,
      ),
      body: ListView.builder(
        itemCount: aiFeatures.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final feature = aiFeatures[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade100,
                child: Text("${index + 1}", style: TextStyle(color: Colors.black)),
              ),
              title: Text(
                feature["title"] ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(feature["desc"] ?? ""),
              ),
            ),
          );
        },
      ),
    );
  }
}
